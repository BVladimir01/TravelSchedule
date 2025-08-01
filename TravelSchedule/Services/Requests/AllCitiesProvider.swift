//
//  AllStationsProvider.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

final class AllCitiesProvider {
    
    private let allStationsService: AllStationsService
    private let mapper = APIStructsMapper()
    
    init(client: APIProtocol) {
        self.allStationsService = AllStationsService(client: client)
    }
    
    func fetchCities() async throws -> [City] {
        guard let countries = try? await allStationsService.getAllStations().countries else {
            throw CitiesFetchingError.serverError
        }
        guard let russia = countries.first(where: { $0.title?.lowercased() == "россия" }),
              let regions = russia.regions else {
            throw CitiesFetchingError.parsingError
        }
        var cities: [Components.Schemas.Settlement] = []
        for region in regions {
            if let settlements = region.settlements{
                cities.append(contentsOf: settlements)
            }
        }
        return cities.map { mapper.map(city: $0) }
    }
    
}
