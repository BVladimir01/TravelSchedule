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
    
    @Published private var loadingState: DataLoadingState = .idle
    
    private let threadsProvider: ThreadsProvider
    private var pageNumber = 0
    
    private let threadMapper = ThreadModelMapper()
    
    @Published private(set) var threads: [Thread] = [ ]
    
    @Published var timeSpecification: Set<TimeInterval> = []
    @Published var allowTransfers = true
    
    init(client: APIProtocol) {
        threadsProvider = ThreadsProvider(client: client)
    }
    
    var isSearchSpecified: Bool {
        !timeSpecification.isEmpty || !allowTransfers
    }
    
    func configure(origin: Station, destination: Station) {
        self.origin = origin
        self.destination = destination
    }

    func threadUIModel(for thread: Thread) -> ThreadUIModel {
        threadMapper.map(thread)
    }
    
    func fetchThreads() {
        guard let origin, let destination else {
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
                    print(threads)
                }
            } catch {
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
