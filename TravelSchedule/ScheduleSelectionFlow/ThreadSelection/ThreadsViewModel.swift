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
        .init(departureTime: Date.now,
              arrivalTime: Date.now.addingTimeInterval(-50000),
              hasTransfers: true,
              carrier: .init(title: "РЖД",
                             email: "i.lozgkina@yandex.ru",
                             phone: "+7 (904) 329-27-71",
                             logoURL: "https://company.rzd.ru/api/media/resources/1603629")),
        
            .init(departureTime: Date.now.addingTimeInterval(-120000),
                  arrivalTime: Date.now.addingTimeInterval(-118000),
                  hasTransfers: true,
                  carrier: .init(title: "Some company",
                                 email: "Some email",
                                 phone: "Some phone",
                                 logoURL: "https://company.rzd.ru/api/media/resources/1603629")),
    ]
    
    init(request: HTTPRequest) {
        
    }
    
    
}
