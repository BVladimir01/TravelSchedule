//
//  ThreadsViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import SwiftUI
import HTTPTypes

final class ThreadsViewModel: ObservableObject {
    
    private let origin: Location
    private let destination: Location
    
    init(origin: Location, destination: Location) {
        self.origin = origin
        self.destination = destination
    }
    
    @Published private(set) var threads: [Thread] = [ ]
    
    @Published var timeSpecification: Set<TimeInterval> = []
    @Published var allowTransfers = true
    
    var isSearchSpecified: Bool {
        !timeSpecification.isEmpty || !allowTransfers
    }
    
    private let threadMapper = ThreadModelMapper()

    func threadUIModel(for thread: Thread) -> ThreadUIModel {
        threadMapper.map(thread)
    }
    
    var navigationBarTitle: String {
        "\(origin.city) (\(origin.station)) → \(destination.city) (\(destination.station))"
    }
    
}
