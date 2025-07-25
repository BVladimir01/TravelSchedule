//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Vladimir on 25.07.2025.
//

typealias CarrierResponse = Components.Schemas.CarrierResponse
typealias CarrierCodeSystem = Operations.getCarrier.Input.Query.systemPayload


protocol CarrierServiceProtocol {
    func getCarrier(code: String, system: CarrierCodeSystem) async throws -> CarrierResponse
}


struct CarrierService: CarrierServiceProtocol {
    
    private let client: APIProtocol
    private let apiKey: String
    
    init(client: APIProtocol, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getCarrier(code: String, system: CarrierCodeSystem) async throws -> CarrierResponse {
        let query = Operations.getCarrier.Input.Query(apikey: apiKey, code: code, system: system)
        let request = try await client.getCarrier(query: query)
        return try request.ok.body.json
    }
    
}
