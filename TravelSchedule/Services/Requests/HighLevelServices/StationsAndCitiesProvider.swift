//
//  StationsAndCitiesProvider.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

import Foundation


// MARK: - StationsAndCitiesProvider
final class StationsAndCitiesProvider: Sendable {
    
    // MARK: - Private Properties

    private let allStationsService: AllStationsService
    private let mapper = APIStationsAndCitiesMapper()
    
    // MARK: - Initializers
    
    init(client: APIProtocol) {
        self.allStationsService = AllStationsService(client: client)
    }
    
    // MARK: - Internal Methods
    
    func fetchCitiesAndStations() async throws -> [City:[Station]] {
        do {
            let countriesResponse = try await allStationsService.getAllStations()
            guard let countries = countriesResponse.countries,
                  let russia = countries.first(where: { $0.title?.lowercased() == "россия" }),
                  let regions = russia.regions
            else {
                throw DataFetchingError.parsingError
            }
            let citiesAndStations: [City: [Station]] = try regions
                .compactMap { $0.settlements }
                .flatMap { $0 }
                .compactMap { try stations(at: $0 )}
                .reduce(into: [City: [Station]]()) { result, next in
                    result[next.city] = next.stations
                }
            return citiesAndStations
        } catch let urlError as URLError {
            print(urlError)
            switch urlError.code {
            case .notConnectedToInternet :
                throw DataFetchingError.noInternetError
            case .timedOut:
                throw DataFetchingError.noInternetError
            default:
                throw DataFetchingError.serverError(description: urlError.localizedDescription)
            }
        } catch {
            print(error)
            throw DataFetchingError.serverError(description: error.localizedDescription)
        }
    }
    
    // MARK: - Private Methods
    
    private func stations(at settlement: Components.Schemas.Settlement) throws -> (city: City, stations: [Station])? {
        guard let city = mapper.map(city: settlement),
              let allStations = settlement.stations
        else {
            return nil
        }
        let trainStations = allStations
            .filter({ $0.transport_type == .train})
            .compactMap { mapper.map(station: $0) }
        if trainStations.isEmpty {
            return nil
        } else {
            return (city: city, stations: trainStations)
        }
    }
    
}
