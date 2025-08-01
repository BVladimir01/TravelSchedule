//
//  AllStationsProvider.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

final class AllStationsProvider {
    
    private(set) var allCities: [City] = []
    
    private let allStationsService: AllStationsService
    private let mapper = APIStructsMapper()
    
    init(client: APIProtocol) {
        self.allStationsService = AllStationsService(client: client)
    }
    
    func loadStations() async {
        guard let countries = try? await allStationsService.getAllStations().countries else { return }
        guard let russia = countries.first(where: { $0.title?.lowercased() == "россия" }) else { return }
        guard let regions = russia.regions else { return }
        var cities: [Components.Schemas.Settlement] = []
        for region in regions {
            if let settlements = region.settlements{
                cities.append(contentsOf: settlements)
            }
        }
        allCities = cities.map { mapper.map(city: $0) }
        print(allCities.count)
    }
    
}
