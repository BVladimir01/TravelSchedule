//
//  ScheduleService.swift
//  TravelSchedule
//
//  Created by Vladimir on 25.07.2025.
//

typealias ScheduleResponse = Components.Schemas.ScheduleResponse


protocol ScheduleServiceProtocol {
    func getSchedules(for station: String) async throws -> ScheduleResponse
}


struct ScheduleService: ScheduleServiceProtocol {
    
    private let client: APIProtocol
    
    init(client: APIProtocol) {
        self.client = client
    }
    
    func getSchedules(for station: String) async throws -> ScheduleResponse {
        let query = Operations.getSchedules.Input.Query(station: station)
        let request = try await client.getSchedules(query: query)
        return try request.ok.body.json
    }
}
