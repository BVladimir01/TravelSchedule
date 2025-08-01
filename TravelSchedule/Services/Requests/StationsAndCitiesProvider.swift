//
//  StationsAndCitiesProvider.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

final class StationsAndCitiesProvider {
    
    private(set) var cities: [City] = []
    
    private var stations: [City:[Station]] = [:]
    private let allStationsService: AllStationsService
    private let mapper = APIStructsMapper()
    
    init(client: APIProtocol) {
        self.allStationsService = AllStationsService(client: client)
    }
    
    func fetchCities() async throws {
        guard let countries = try? await allStationsService.getAllStations().countries else {
            throw AllStationsFetchingError.serverError
        }
        guard let russia = countries.first(where: { $0.title?.lowercased() == "россия" }),
              let regions = russia.regions else {
            throw AllStationsFetchingError.parsingError
        }
        for region in regions {
            if let settlements = region.settlements {
                for settlement in settlements {
                    renderSettlement(settlement)
                }
            }
        }
    }
    
    func stations(of city: City) -> [Station] {
        return stations[city] ?? []
    }
    
    private func renderSettlement(_ settlement: Components.Schemas.Settlement) {
        let city = mapper.map(city: settlement)
        guard let stations = settlement.stations else { return }
        cities.append(city)
        self.stations[city] = stations.map { mapper.map(station: $0) }
    }
    
}
