//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Vladimir on 23.07.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    
    private let client: APIProtocol
    private let apiKey: String
    
    let printTerminator = "\n------------------\n"
    
    init(client: APIProtocol, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
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
//            getAllStations()
            getCarrier()
        }
    }
    
    private func performRequests() {
        getNearestStations()
        getCopyright()
        getAllStations()
    }
    
    private func getNearestStations() {
        Task {
            do {
                let service = NearestStationsService(client: client,
                                                     apiKey: apiKey)
                print("fetching stations...",
                      terminator: printTerminator)
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                print("stations:", stations.stations!.map {$0.title},
                      terminator: printTerminator)
            } catch {
                print("error: \(error)",
                      terminator: printTerminator)
            }
        }
    }
    
    private func getCopyright() {
        Task {
            do {
                let service = CopyrightService(client: client,
                                               apiKey: apiKey)
                print("fetching copyright...",
                      terminator: printTerminator)
                let copyright = try await service.getCopyright()
                print("copyright:", copyright,
                      terminator: printTerminator)
            } catch {
                print("error: \(error)",
                      terminator: printTerminator)
            }
        }
    }
    
    private func getAllStations() {
        Task {
            do {
                let service = AllStationsService(client: client,
                                                 apiKey: apiKey)
                print("fetching all stations",
                      terminator: printTerminator)
                let allStations = try await service.getAllStations()
                print("all stations:", allStations,
                      terminator: printTerminator)
            } catch {
                print("error: \(error)",
                      terminator: printTerminator)
            }
        }
    }
    
    private func getCarrier() {
        Task {
            do {
                let service = CarrierService(client: client,
                                             apiKey: apiKey)
                print("fetching carrier",
                      terminator: printTerminator)
                let carrierResponse = try await service.getCarrier()
                print("carrier:", carrierResponse,
                      terminator: printTerminator)
            } catch {
                print("error: \(error)",
                      terminator: printTerminator)
            }
        }
    }
    
}


#Preview {
    let client = try! Client(serverURL: Servers.Server1.url(), transport: URLSessionTransport())
    let apiKey = "f5fad011-aeea-4dab-a7a8-872458a66b1f"
    ContentView(client: client, apiKey: apiKey)
}
