//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Vladimir on 23.07.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    
    let client: APIProtocol
    let apiKey: String
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
//            getNearestStations()
//            getCopyright()
        }
    }
    
    func getNearestStations() {
        Task {
            do {
                let service = NearestStationsService(client: client,
                                                     apiKey: apiKey)
                print("fetching stations...",
                      terminator: "\n------------------\n")
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                print("stations:", stations.stations!.map {$0.title},
                      terminator: "\n------------------\n")
            } catch {
                print("error: \(error)",
                      terminator: "\n------------------\n")
            }
        }
    }
    
    func getCopyright() {
        Task {
            do {
                let service = CopyrightService(client: client,
                                               apiKey: apiKey)
                print("fetching copyright...",
                      terminator: "\n------------------\n")
                let copyright = try await service.getCopyright()
                print("copyright:", copyright.copyright?.text,
                      terminator: "\n------------------\n")
            } catch {
                print("error: \(error)",
                      terminator: "\n------------------\n")
            }
        }
    }
    
}

#Preview {
    let client = try! Client(serverURL: Servers.Server1.url(), transport: URLSessionTransport())
    let apiKey = "f5fad011-aeea-4dab-a7a8-872458a66b1f"
    ContentView(client: client, apiKey: apiKey)
}
