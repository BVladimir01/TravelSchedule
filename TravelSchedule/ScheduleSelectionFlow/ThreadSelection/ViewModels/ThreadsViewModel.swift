//
//  ThreadsViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import HTTPTypes
import SwiftUI


// MARK: - ThreadsViewModel
@MainActor
final class ThreadsViewModel: ObservableObject {
    
    // MARK: - Internal Properties - State
    
    @Published private(set) var loadingState: DataLoadingState = .idle

    @Published var timeSpecifications: Set<TimeInterval>

    @Published var allowTransfers = true
    
    // MARK: - Internal Properties
    
    let origin: Station
    let destination: Station
    
    let allTimeIntervals = [
        TimeInterval(start: RelativeTimePoint(hour: 6, minute: 0), end: RelativeTimePoint(hour: 12, minute: 0), description: "Утро"),
        TimeInterval(start: RelativeTimePoint(hour: 12, minute: 0), end: RelativeTimePoint(hour: 18, minute: 0), description: "День"),
        TimeInterval(start: RelativeTimePoint(hour: 18, minute: 0), end: RelativeTimePoint(hour: 24, minute: 0), description: "Вечер"),
        TimeInterval(start: RelativeTimePoint(hour: 0, minute: 0), end: RelativeTimePoint(hour: 6, minute: 0), description: "Ночь"),
        
    ]
    
    var displayedThreads: [Thread] {
        threads.filter { thread in
            let transfersConditionPassed = allowTransfers || !thread.hasTransfers
            let timeConditionPassed = timeSpecifications.contains(where: { $0.contains(timePoint: thread.departureTime) })
            return transfersConditionPassed && timeConditionPassed
        }
    }
    
    var isSearchSpecified: Bool {
        timeSpecifications.count < allTimeIntervals.count || !allowTransfers
    }

    // MARK: - Private Properties - State
    
    @Published private var threads: [Thread] = []
    
    // MARK: - Private Properties
    
    private let threadsProvider: ThreadsProvider
    private var pageNumber = 0
    private let threadMapper = ThreadModelUIMapper()
    
    // MARK: - Initializers
    
    init(origin: Station, destination: Station, client: APIProtocol) {
        self.origin = origin
        self.destination = destination
        threadsProvider = ThreadsProvider(client: client)
        timeSpecifications = Set(allTimeIntervals)
        fetchThreads()
    }
    
    // MARK: - Internal Methods

    func fetchThreads() {
        Task {
            loadingState = .loading
            do {
                let newThreads = try await threadsProvider.fetchTreads(from: origin,
                                                                       to: destination,
                                                                       pageNumber: pageNumber)
                threads.append(contentsOf: newThreads)
                loadingState = .success
            } catch let error as DataFetchingError {
                print(error)
                loadingState = .error(error)
            }
        }
    }
    
}
