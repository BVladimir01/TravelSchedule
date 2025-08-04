//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Vladimir on 23.07.2025.
//

import OpenAPIURLSession
import SwiftUI


// MARK: - MainView
struct MainView: View {
    
    // MARK: - Private Properties - State
    
    @State private var selectedTab: Tab = .schedule
    @StateObject private var scheduleNavigationViewModel: ScheduleNavigationViewModel
    
    // MARK: - Private Properties
    
    @Environment(\.colorScheme) private var colorScheme
    private let client: APIProtocol
    
    // MARK: - Initializers
    
    init(client: APIProtocol) {
        self._scheduleNavigationViewModel = StateObject(wrappedValue: ScheduleNavigationViewModel(client: client))
        self.client = client
    }
    
    // MARK: - Views
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
//            divider
        }
    }
    
    private var divider: some View {
        Rectangle()
            .fill(colorScheme == .light ? .ypLightGray : .ypGray)
            .frame(height: 1)
            .ignoresSafeArea(edges: .horizontal)
            .offset(y: -49)
    }
    
    private var content: some View {
        TabView(selection: $selectedTab) {
            ScheduleNavigationRootView(viewModel: scheduleNavigationViewModel,
                                       client: client)
                .tabItem {
                    Image(.schedule)
                }
                .tag(Tab.schedule)
            SettingsView()
                .tabItem {
                    Image(.settings)
                }
                .tag(Tab.settings)
        }
        .tint(.ypBlack)
    }
    
}

// MARK: - Tabs
extension MainView {
    private enum Tab {
        case schedule, settings
    }
}

#Preview {
    let apiKey = "f5fad011-aeea-4dab-a7a8-872458a66b1f"
    let apiKeyMiddleware = APIKeyMiddleware(apiKey: apiKey)
    let client = try! Client(serverURL: Servers.Server1.url(), transport: URLSessionTransport(), middlewares: [apiKeyMiddleware])
    MainView(client: client)
}
