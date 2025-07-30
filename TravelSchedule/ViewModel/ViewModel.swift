//
//  ViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


final class ViewModel: ObservableObject {
    
    private let citiesStations = [
        "Moscow" : ["Yaroslavskiy", "Kazanskiy", "Belorusskiy"],
        "SPB" : ["station 1", "station 2", "station 3"],
        "Kazan": ["station 1", "station 2", "station 3"]
    ]
    
    var cities: [String] {
        Array(citiesStations.keys)
    }
    
    func stations(of city: String) -> [String] {
        citiesStations[city] ?? []
    }
    
    var latestSelectedCity: String? = nil
    
    @Published var originLocation = Location()
    @Published var destinationLocation = Location()
    
    @Published var selectedIntervals: [TimeInterval] = []
    @Published var allowTransfers = false
    
    @Published var path: [Destination] = []
    
    var searchIsEnabled: Bool {
        return (originLocation.city != nil &&
                originLocation.station != nil &&
                destinationLocation.city != nil &&
                destinationLocation.station != nil)
    }
    
    func selectDestinationLocation() {
        path.append(.city(selection: .destination))
    }
    
    func selectOriginLocation() {
        path.append((.city(selection: .origin)))
    }
    
    func selectCity(_ city: String, for selection: Selection) {
        switch selection {
        case .origin:
            originLocation.city = city
        case .destination:
            destinationLocation.city = city
        }
        path.append(.station(selection: selection))
    }
    
    func selectStation(_ station: String, for selection: Selection) {
        switch selection {
        case .origin:
            originLocation.station = station
        case .destination:
            destinationLocation.station = station
        }
        path = []
    }
    
}
