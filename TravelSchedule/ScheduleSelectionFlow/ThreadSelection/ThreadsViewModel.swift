//
//  ThreadsViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import SwiftUI
import HTTPTypes

final class ThreadsViewModel: ObservableObject {
    
    private var origin: Station?
    private var destination: Station?
    
    @Published private(set) var loadingState: DataLoadingState = .idle
    
    private let threadsProvider: ThreadsProvider
    private var pageNumber = 0
    
    private let threadMapper = ThreadModelMapper()
    
    @Published private var threads: [Thread] = []
    
    var displayedThreads: [Thread] {
        threads.filter { thread in
            let transfersConditionPassed = allowTransfers || !thread.hasTransfers
            let timeConditionPassed = timeSpecifications.contains(where: { $0.contains(timePoint: thread.departureTime) })
            return transfersConditionPassed && timeConditionPassed
        }
    }
    
    @Published var timeSpecifications: Set<TimeInterval>
    
    let allTimeIntervals = [
        TimeInterval(start: RelativeTimePoint(hour: 6, minute: 0), end: RelativeTimePoint(hour: 12, minute: 0), description: "Утро"),
        TimeInterval(start: RelativeTimePoint(hour: 12, minute: 0), end: RelativeTimePoint(hour: 18, minute: 0), description: "День"),
        TimeInterval(start: RelativeTimePoint(hour: 18, minute: 0), end: RelativeTimePoint(hour: 24, minute: 0), description: "Вечер"),
        TimeInterval(start: RelativeTimePoint(hour: 0, minute: 0), end: RelativeTimePoint(hour: 6, minute: 0), description: "Ночь"),
        
    ]
    @Published var allowTransfers = true
    
    init(client: APIProtocol) {
        threadsProvider = ThreadsProvider(client: client)
        timeSpecifications = Set(allTimeIntervals)
    }
    
    var isSearchSpecified: Bool {
        timeSpecifications.count < allTimeIntervals.count || !allowTransfers
    }
    
    func configure(origin: Station, destination: Station) {
        self.origin = origin
        self.destination = destination
    }

    func threadUIModel(for thread: Thread) -> ThreadUIModel {
        threadMapper.map(thread)
    }
    
    func fetchThreads() {
        guard let origin, let destination,
              loadingState != .loading
        else {
            return
        }
        Task {
            await MainActor.run {
                loadingState = .loading
            }
            do {
                let newThreads = try await threadsProvider.fetchTreads(from: origin,
                                                                       to: destination,
                                                                       pageNumber: pageNumber)
                await MainActor.run {
                    threads.append(contentsOf: newThreads)
                    loadingState = .success
                }
            } catch let error as DataFetchingError {
                await MainActor.run {
                    print(error)
                    loadingState = .error(error)
                }
            }
        }
    }
    
    func performInitialFetch() {
        guard let origin, let destination,
              loadingState != .loading,
              threads.isEmpty
        else {
            return
        }
        Task {
            await MainActor.run {
                loadingState = .loading
            }
            do {
                let newThreads = try await threadsProvider.fetchTreads(from: origin,
                                                                       to: destination,
                                                                       pageNumber: pageNumber)
                await MainActor.run {
                    threads.append(contentsOf: newThreads)
                    loadingState = .success
                }
            } catch let error as DataFetchingError {
                await MainActor.run {
                    print(error)
                    loadingState = .error(error)
                }
            }
        }
    }
    
    var navigationBarTitle: String {
        guard let origin, let destination else {
            return ""
        }
        return "\(origin.title) → \(destination.title)"
    }
    
}
