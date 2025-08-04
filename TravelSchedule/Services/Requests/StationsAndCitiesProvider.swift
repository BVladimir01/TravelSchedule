//
//  StationsAndCitiesProvider.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

import Foundation


// MARK: - StationsAndCitiesProvider
final class StationsAndCitiesProvider {
    
    // MARK: - Internal Properties
    
    private(set) var cities: [City] = []
    
    // MARK: - Private Properties
    
    private var stations: [City:[Station]] = [:]
    private let allStationsService: AllStationsService
    private let mapper = APIStructsMapper()
    
    // MARK: - Initializers
    
    init(client: APIProtocol) {
        self.allStationsService = AllStationsService(client: client)
    }
    
    // MARK: - Internal Methods
    
    func fetchCitiesAndStations() async throws {
        do {
            let countriesResponse = try await allStationsService.getAllStations()
            guard let countries = countriesResponse.countries,
                  let russia = countries.first(where: { $0.title?.lowercased() == "россия" }),
                  let regions = russia.regions
            else {
                throw DataFetchingError.parsingError
            }
            for region in regions {
                if let settlements = region.settlements {
                    for settlement in settlements {
                        renderSettlement(settlement)
                    }
                }
            }
        } catch let urlError as URLError {
            print(urlError)
            switch urlError.code {
            case .notConnectedToInternet :
                throw DataFetchingError.noInternetError
            case .timedOut:
                throw DataFetchingError.noInternetError
            default:
                throw DataFetchingError.serverError(error: urlError)
            }
        } catch {
            print(error)
            throw DataFetchingError.serverError(error: error)
        }
    }
    
    func stations(of city: City) -> [Station] {
        return stations[city] ?? []
    }
    
    // MARK: - Private Methods
    
    private func renderSettlement(_ settlement: Components.Schemas.Settlement) {
        guard let city = mapper.map(city: settlement) else { return }
        guard let stations = settlement.stations else { return }
        let trainStations = stations.filter({ $0.transport_type == .train}).compactMap { mapper.map(station: $0) }
        if !trainStations.isEmpty {
            cities.append(city)
            self.stations[city] = trainStations
        }
    }
    
}
