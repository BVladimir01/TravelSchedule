//
//  ViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


@MainActor
final class ScheduleNavigationViewModel: ObservableObject {
    
    @Published var loadingState: DataLoadingState = .idle
    
    @Published var originCity: City?
    @Published var originStation: Station?
    @Published var destinationCity: City?
    @Published var destinationStation: Station?
    
    @Published var path: [PageType] = []
    
    
    private let stationsAndCitiesProvider: StationsAndCitiesProvider
    
    init(client: APIProtocol) {
        stationsAndCitiesProvider = StationsAndCitiesProvider(client: client)
        startFetching()
    }
    
    private func startFetching() {
        Task {
            await MainActor.run {
                loadingState = .loading
            }
            do {
                try await stationsAndCitiesProvider.fetchCitiesAndStations()
                await MainActor.run {
                    loadingState = .success
                }
            } catch let error as DataFetchingError {
                await MainActor.run {
                    loadingState = .error(error)
                }
            }
        }
    }
    
    private let citiesStations = [
        "Moscow" : ["Yaroslavskiy", "Kazanskiy", "Belorusskiy"],
        "SPB" : ["station 1", "station 2", "station 3"],
        "Kazan": ["station 1", "station 2", "station 3"]
    ]
    
    func description(for locationType: LocationType) -> String? {
        let cityTitle: String?
        let stationTitle: String?
        switch locationType {
        case .origin:
                cityTitle = originCity?.title
                stationTitle = originStation?.title
        case .destination:
            cityTitle = destinationCity?.title
            stationTitle = destinationStation?.title
        }
        if let cityTitle, let stationTitle {
            return "\(cityTitle) (\(stationTitle))"
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
    
    var cities: [City] {
        stationsAndCitiesProvider.cities
    }
    
    func stations(of city: City) -> [Station] {
        stationsAndCitiesProvider.stations(of: city)
    }
    
    func city(of locationType: LocationType) -> City? {
        switch locationType {
        case .origin:
            return originCity
        case .destination:
            return destinationCity
        }
    }
    
    var searchIsEnabled: Bool {
        return (originCity != nil &&
                originStation != nil &&
                destinationCity != nil &&
                destinationStation != nil
                )
    }
    
    func searchCity(for locationType: LocationType) {
        path.append(.citySelection(locationType: locationType))
    }
    
    func selectCity(_ city: City, for locationType: LocationType) {
        switch locationType {
        case .origin:
            originCity = city
        case .destination:
            destinationCity = city
        }
        path.append(.stationSelection(locationType: locationType))
//        path.removeAll()
    }
    
    func selectStation(_ station: Station, for locationType: LocationType) {
        switch locationType {
        case .origin:
            originStation = station
        case .destination:
            destinationStation = station
        }
        // this is a walkaround
        // popping all views causes ui to freeze
        // don't know other solutions
        Task {
            await MainActor.run {
                _ = path.popLast()
            }
            try await Task.sleep(nanoseconds: 5_000_000)
            await MainActor.run {
                _ = path.popLast()
            }
        }
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
