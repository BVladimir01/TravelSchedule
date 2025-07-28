//
//  NearestSettlementService.swift
//  TravelSchedule
//
//  Created by Vladimir on 25.07.2025.
//

typealias NearestSettlement = Components.Schemas.NearestSettlement


protocol NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlement
}


struct NearestSettlementService: NearestSettlementServiceProtocol {
    
    private let client: APIProtocol
    
    init(client: APIProtocol) {
        self.client = client
    }
    
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlement {
        let query = Operations.getNeaerstSettlement.Input.Query(lng: lng, lat: lat, distance: distance)
        let request = try await client.getNeaerstSettlement(query: query)
        return try request.ok.body.json
    }
    
}
