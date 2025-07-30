//
//  ViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


final class ViewModel: ObservableObject {
    
    @Published var originLocation: Location? = nil
    @Published var destinationLocation: Location? = nil
    
    @Published var selectedIntervals: [TimeInterval] = []
    @Published var allowTransfers = false
    
    @Published var path: [Destination] = []
    
    var searchIsEnabled: Bool {
        return (originLocation?.city != nil &&
                originLocation?.station != nil &&
                destinationLocation?.city != nil &&
                destinationLocation?.station != nil)
    }
    
}
