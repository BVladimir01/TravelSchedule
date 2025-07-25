//
//  AllStationsService.swift
//  TravelSchedule
//
//  Created by Vladimir on 25.07.2025.
//

import Foundation
import OpenAPIRuntime


typealias AllStations = Components.Schemas.AllStationsResponse


protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations
}


struct AllStationsService: AllStationsServiceProtocol {
    
    private let client: APIProtocol
    private let apiKey: String
    
    init(client: APIProtocol, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getAllStations() async throws -> AllStations {
        let query = Operations.getAllStations.Input.Query(apikey: apiKey)
        let request = try await client.getAllStations(query: query)
        let body = try request.ok.body
        switch body {
        case .html(let httpBody):
            return try await decode(httpBody: httpBody)
        case .json(let jsonBody):
            return jsonBody
        }
    }
    
    private func decode(httpBody: HTTPBody) async throws -> AllStations {
        let data = try await Data(collecting: httpBody, upTo: .max)
        return try JSONDecoder().decode(AllStations.self, from: data)
    }
}
