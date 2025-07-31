//
//  ViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


final class ScheduleNavigationViewModel: ObservableObject {
    
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
    
    func city(of locationType: LocationType) -> String? {
        switch locationType {
        case .origin:
            return originLocation.city
        case .destination:
            return destinationLocation.city
        }
    }
    
    @Published var originLocation = Location()
    @Published var destinationLocation = Location()
    
    @Published var selectedIntervals: [TimeInterval] = []
    @Published var allowTransfers = false
    
    @Published var path: [PageType] = []
    
    var searchIsEnabled: Bool {
        return (originLocation.isDefined &&
                destinationLocation.isDefined)
    }
    
    func searchCity(for locationType: LocationType) {
        path.append(.citySelection(locationType: locationType))
    }
    
    func selectCity(_ city: String, for locationType: LocationType) {
        switch locationType {
        case .origin:
            originLocation.city = city
        case .destination:
            destinationLocation.city = city
        }
        path.append(.stationSelection(locationType: locationType))
    }
    
    func selectStation(_ station: String, for locationType: LocationType) {
        switch locationType {
        case .origin:
            originLocation.station = station
        case .destination:
            destinationLocation.station = station
        }
        path = []
    }
    
    func swapLocationTypes() {
        let temporary = originLocation
        originLocation = destinationLocation
        destinationLocation = temporary
    }
    
    func searchThreads() {
        path.append(.threadSelection)
    }
}
