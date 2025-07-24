//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Vladimir on 23.07.2025.
//

import SwiftUI
import OpenAPIURLSession

@main
struct TravelScheduleApp: App {
    var body: some Scene {
        WindowGroup {
            let client = try! Client(serverURL: Servers.Server1.url(), transport: URLSessionTransport())
            let apiKey = "f5fad011-aeea-4dab-a7a8-872458a66b1f"
            ContentView(client: client, apiKey: apiKey)
        }
    }
}
