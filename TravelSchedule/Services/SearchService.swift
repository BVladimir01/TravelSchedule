//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Vladimir on 25.07.2025.
//

typealias SearchResponse = Components.Schemas.SearchResponse


protocol SearchServiceProtocol {
    func getSchedules(from: String, to: String) async throws -> SearchResponse
}


struct SearchService: SearchServiceProtocol {
    
    private let client: APIProtocol
    private let apiKey: String
    
    init(client: APIProtocol, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getSchedules(from departure: String, to destination: String) async throws -> SearchResponse {
        let query = Operations.searchSchedules.Input.Query(apikey: apiKey, from: departure, to: destination)
        let request = try await client.searchSchedules(query: query)
        return try request.ok.body.json
    }
}
