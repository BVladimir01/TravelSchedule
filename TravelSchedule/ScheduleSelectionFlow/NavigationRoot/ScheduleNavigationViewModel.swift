//
//  ViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


final class ScheduleNavigationViewModel: ObservableObject {
    
    @Published private(set) var loadingState: CitiesLoadingState = .idle
    
    @Published var originCity: String?
    @Published var originStation: String?
    @Published var destinationCity: String?
    @Published var destinationStation: String?
    
    @Published var path: [PageType] = []
    @Published var _cities: [City] = []
    
    private let allCitiesProvider: AllCitiesProvider
    
    init(client: APIProtocol) {
        allCitiesProvider = AllCitiesProvider(client: client)
        startFetching()
    }
    
    private func startFetching() {
        Task {
            loadingState = .loading
            do {
                _cities = try await allCitiesProvider.fetchCities()
                loadingState = .success
            } catch {
                loadingState = .error(error)
            }
        }
    }
    
    private let citiesStations = [
        "Moscow" : ["Yaroslavskiy", "Kazanskiy", "Belorusskiy"],
        "SPB" : ["station 1", "station 2", "station 3"],
        "Kazan": ["station 1", "station 2", "station 3"]
    ]
    
    func location(of type: LocationType) -> Location? {
        switch type {
        case .origin:
            if let originCity, let originStation {
                return Location(city: originCity, station: originStation)
            } else {
                return nil
            }
        case .destination:
            if let destinationCity, let destinationStation {
                return Location(city: destinationCity, station: destinationStation)
            } else {
                return nil
            }
        }
    }

    func description(for locationType: LocationType) -> String? {
        let city: String?
        let station: String?
        switch locationType {
        case .origin:
            if let originCity, let originStation {
                city = originCity
                station = originStation
            } else {
                city = nil
                station = nil
            }
        case .destination:
            if let destinationCity, let destinationStation {
                city = destinationCity
                station = destinationStation
            } else {
                city = nil
                station = nil
            }
        }
        if let city, let station {
            return "\(city) (\(station))"
        } else {
            return nil
        }
    }
    
    func isDefined(locationType: LocationType) -> Bool {
        switch locationType {
        case .origin:
            return originCity != nil && originStation != nil
        case .destination:
            return destinationCity != nil && destinationStation != nil
        }
    }
    
    var cities: [String] {
        Array(citiesStations.keys)
    }
    
    func stations(of city: String) -> [String] {
        citiesStations[city] ?? []
    }
    
    func city(of locationType: LocationType) -> String? {
        switch locationType {
        case .origin:
            return originCity
        case .destination:
            return destinationCity
        }
    }
    
    var searchIsEnabled: Bool {
        return [originCity, originStation, destinationCity, destinationStation].allSatisfy { $0 != nil }
    }
    
    func searchCity(for locationType: LocationType) {
        path.append(.citySelection(locationType: locationType))
    }
    
    func selectCity(_ city: String, for locationType: LocationType) {
        switch locationType {
        case .origin:
            originCity = city
        case .destination:
            destinationCity = city
        }
        path.append(.stationSelection(locationType: locationType))
    }
    
    func selectStation(_ station: String, for locationType: LocationType) {
        switch locationType {
        case .origin:
            originStation = station
        case .destination:
            destinationStation = station
        }
        path = []
    }
    
    func swapLocationTypes() {
        let tempCity = originCity
        let tempStation = originStation
        originCity = destinationCity
        destinationCity = tempCity
        originStation = destinationStation
        destinationStation = tempStation
    }
    
    func searchThreads() {
        path.append(.threadSelection)
    }

}
