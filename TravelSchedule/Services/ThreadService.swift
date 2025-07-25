//
//  ThreadService.swift
//  TravelSchedule
//
//  Created by Vladimir on 25.07.2025.
//

typealias RouteThread = Components.Schemas.Thread


protocol ThreadServiceProtocol {
    func getThread(id: String) async throws -> RouteThread
}


struct ThreadService: ThreadServiceProtocol {
    
    private let client: APIProtocol
    private let apiKey: String
    
    init(client: APIProtocol, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getThread(id: String) async throws -> RouteThread {
        let query = Operations.getThread.Input.Query(apikey: apiKey, uid: id, show_systems: .all)
        let request = try await client.getThread(query: query)
        return try request.ok.body.json
    }
    
}
