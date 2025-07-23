//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Vladimir on 23.07.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
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
        }
    }
    
    func getNearestStations() {
        Task {
            do {
                let client = try Client(serverURL: Servers.Server1.url(), transport: URLSessionTransport())
                let service = NearestStationsService(client: client, apiKey: "f5fad011-aeea-4dab-a7a8-872458a66b1f")
                print("fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                print("stations:")
                print(stations.stations, separator: "\n-------------------\n")
            } catch {
                print("error: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
