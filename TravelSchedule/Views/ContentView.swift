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
    
    let printTerminator = "\n------------------\n"
    
    init(client: APIProtocol) {
        self.client = client
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
//            performRequests()
//            getCopyright()
        }
    }
    
    private func performRequests() {
        getNearestStations()
        getCopyright()
        getAllStations()
        getCarrier()
        getNearestSettlement()
        getThread()
        getSchedules()
        searchSchedules()
    }
    
    private func getNearestStations() {
        Task {
            do {
                let service = NearestStationsService(client: client)
                print("fetching stations...",
                      terminator: printTerminator)
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                print("stations:", stations,
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
                let service = CopyrightService(client: client)
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
                let service = AllStationsService(client: client)
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
                let service = CarrierService(client: client)
                print("fetching carrier",
                      terminator: printTerminator)
                let carrierResponse = try await service.getCarrier(code: "SU",
                                                                   system: .iata)
                print("carrier:", carrierResponse,
                      terminator: printTerminator)
            } catch {
                print("error: \(error)",
                      terminator: printTerminator)
            }
        }
    }
    
    private func getNearestSettlement() {
        Task {
            do {
                let service = NearestSettlementService(client: client)
                print("fetching nearest settlement",
                      terminator: printTerminator)
                let nearestSettlement = try await service.getNearestSettlement(
                    lat: 50.440046,
                    lng: 40.4882367,
                    distance: 50
                )
                print("nearest settlement:", nearestSettlement,
                      terminator: printTerminator)
            } catch {
                print("error: \(error)",
                      terminator: printTerminator)
            }
        }
    }
    
    private func getThread() {
        Task {
            do {
                let service = ThreadService(client: client)
                print("fetching thread",
                      terminator: printTerminator)
                let thread = try await service.getThread(id: "SU-1484_250725_c26_12")
                print("thread:", thread,
                      terminator: printTerminator)
            } catch {
                print("error: \(error)",
                      terminator: printTerminator)
            }
        }
    }
    
    private func getSchedules() {
        Task {
            do {
                let service = ScheduleService(client: client)
                print("fetching schedules",
                      terminator: printTerminator)
                let schedules = try await service.getSchedules(for: "s9600213")
                print("schedules:", schedules,
                      terminator: printTerminator)
            } catch {
                print("error: \(error)",
                      terminator: printTerminator)
            }
        }
    }
    
    private func searchSchedules() {
        Task {
            do {
                let service = SearchService(client: client)
                print("fetching schedules",
                      terminator: printTerminator)
                let schedules = try await service.getSchedules(from: "c146",
                                                               to: "c213")
                print("schedules:", schedules,
                      terminator: printTerminator)
            } catch {
                print("error: \(error)",
                      terminator: printTerminator)
            }
        }
    }
    
}


#Preview {
    let apiKey = "f5fad011-aeea-4dab-a7a8-872458a66b1f"
    let apiKeyMiddleware = APIKeyMiddleware(apiKey: apiKey)
    let client = try! Client(serverURL: Servers.Server1.url(), transport: URLSessionTransport(), middlewares: [apiKeyMiddleware])
    ContentView(client: client)
}
