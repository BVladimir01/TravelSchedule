//
//  NearestTrainsService.swift
//  TravelSchedule
//
//  Created by Vladimir on 23.07.2025.
//

typealias NearestStations = Components.Schemas.NearestStationsResponse


protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}


struct NearestStationsService: NearestStationsServiceProtocol {
    
    private let client: APIProtocol
    private let apiKey: String
    
    init(client: APIProtocol, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let query = Operations.getNearestStations.Input.Query(apikey: apiKey, lat: lat, lng: lng, distance: distance, transport_types: .init(arrayLiteral: .train), limit: 10)
        let response = try await client.getNearestStations(query: query)
        return try response.ok.body.json
    }
    
}
