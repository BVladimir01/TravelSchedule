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
    
    init(client: APIProtocol) {
        self.client = client
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let query = Operations.getNearestStations.Input.Query(lat: lat, lng: lng, distance: distance)
        let response = try await client.getNearestStations(query: query)
        return try response.ok.body.json
    }
    
}
