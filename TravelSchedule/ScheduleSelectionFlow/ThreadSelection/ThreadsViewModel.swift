//
//  ThreadsViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import SwiftUI
import HTTPTypes

final class ThreadsViewModel: ObservableObject {
    
    @Published private var threads: [Thread] = [
        .init(departureTime: Date.now.addingTimeInterval(-50000),
              arrivalTime: Date.now,
              hasTransfers: true,
              carrier: .init(title: "РЖД",
                             email: "i.lozgkina@yandex.ru",
                             phone: "+7 (904) 329-27-71",
                             logoURL: "https://company.rzd.ru/api/media/resources/1603629"),
             origin: Location(),
             destination: Location()),
            .init(departureTime: Date.now.addingTimeInterval(-10120000),
                  arrivalTime: Date.now.addingTimeInterval(-10110000),
                  hasTransfers: false,
                  carrier: .init(title: "РЖД",
                                 email: "i.lozgkina@yandex.ru",
                                 phone: "+7 (904) 329-27-71",
                                 logoURL: "https://company.rzd.ru/api/media/resources/1603629"),
                 origin: Location(),
                 destination: Location()),
    ]
    
    @Published var timeSpecification: Set<TimeInterval> = []
    @Published var allowTransfers = true
    
    var isSearchSpecified: Bool {
        !timeSpecification.isEmpty || !allowTransfers
    }
    
    private let threadMapper = ThreadModelMapper()
    
    var threadUIModels: [ThreadUIModel] {
        threads.map { thread in
            threadMapper.map(thread)
        }
    }
    
}
