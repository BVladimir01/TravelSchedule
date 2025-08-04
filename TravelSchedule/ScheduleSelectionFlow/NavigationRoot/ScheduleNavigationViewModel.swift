//
//  ViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


// MARK: - ScheduleNavigationViewModel
final class ScheduleNavigationViewModel: ObservableObject {
    
    // MARK: - Internal Properties - State
    
    @Published private(set) var loadingState: DataLoadingState = .idle
    
    @Published var originCity: City?
    @Published var originStation: Station?
    @Published var destinationCity: City?
    @Published var destinationStation: Station?
    
    @Published var path: [PageType] = []
    
    // MARK: - Private Properties
    
    private let stationsAndCitiesProvider: StationsAndCitiesProvider
    
    // MARK: - Initializers
    
    init(client: APIProtocol) {
        stationsAndCitiesProvider = StationsAndCitiesProvider(client: client)
        fetchCitiesAndStations()
    }
    
    // MARK: Internal Methods
    
    func fetchCitiesAndStations() {
        guard stationsAndCitiesProvider.cities.isEmpty else { return }
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
    
    func showCitySelectionView(for locationType: LocationType) {
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
    
    func showThreadsSelectionView() {
        path.append(.threadSelection)
    }

}
