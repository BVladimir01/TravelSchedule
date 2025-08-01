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
    
    @Published private(set) var threads: [Thread] = [
        .init(departureTime: Date.now.addingTimeInterval(-50000),
              arrivalTime: Date.now,
              hasTransfers: true,
              carrier: .init(title: "РЖД",
                             email: "i.lozgkina@yandex.ru",
                             phone: "+7 (904) 329-27-71",
                             logoURL: "https://company.rzd.ru/api/media/resources/1603629"),
             origin: Location(city: "some city", station: "some station"),
             destination: Location(city: "some city", station: "some station")),
            .init(departureTime: Date.now.addingTimeInterval(-10120000),
                  arrivalTime: Date.now.addingTimeInterval(-10110000),
                  hasTransfers: false,
                  carrier: .init(title: "РЖД",
                                 email: "i.lozgkina@yandex.ru",
                                 phone: "+7 (904) 329-27-71",
                                 logoURL: "https://company.rzd.ru/api/media/resources/1603629"),
                 origin: Location(city: "some city", station: "some station"),
                 destination: Location(city: "some city", station: "some station")),
    ]
    
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
