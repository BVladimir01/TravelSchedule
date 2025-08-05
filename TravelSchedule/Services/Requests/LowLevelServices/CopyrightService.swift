//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Vladimir on 24.07.2025.
//

typealias Copyright = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}


struct CopyrightService: CopyrightServiceProtocol {
    
    private let client: APIProtocol
    
    init(client: APIProtocol) {
        self.client = client
    }
    
    func getCopyright() async throws -> Copyright{
        let query = Operations.getCopyright.Input.Query()
        let response = try await client.getCopyright(query: query)
        return try response.ok.body.json
    }
    
}
