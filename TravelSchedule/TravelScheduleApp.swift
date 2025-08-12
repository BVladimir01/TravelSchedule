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
    
    @StateObject private var tabSelectionVM: TabSelectionViewModel
    @StateObject private var colorSchemeStore = ColorSchemeStore.shared
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: tabSelectionVM)
                .environmentObject(ColorSchemeStore.shared)
                .preferredColorScheme(colorSchemeStore.isDarkTheme ? .dark : .light)
        }
    }
    
    init() {
        let apiKey = "f5fad011-aeea-4dab-a7a8-872458a66b1f"
        let apiKeyMiddleware = APIKeyMiddleware(apiKey: apiKey)
        let client = try! Client(serverURL: Servers.Server1.url(), transport: URLSessionTransport(), middlewares: [apiKeyMiddleware])
        _tabSelectionVM = StateObject.init(wrappedValue: TabSelectionViewModel(client: client))
    }
    
}
