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
    
    @ObservedObject private var vm: TabSelectionViewModel
    
    // MARK: - Private Properties
    
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Initializers
    
    init(viewModel: TabSelectionViewModel) {
        self.vm = viewModel
    }
    
    // MARK: - Views
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
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
        TabView(selection: $vm.currentTab) {
            ScheduleNavigationRootView(viewModel: vm.scheduleNavigationVM)
            .tabItem {
                    Image(.schedule)
                }
            .tag(MainViewTab.scheduleSelection)
            SettingsView()
                .tabItem {
                    Image(.settings)
                }
                .tag(MainViewTab.settings)
        }
        .tint(.ypBlack)
    }
    
}

#Preview {
    let apiKey = "f5fad011-aeea-4dab-a7a8-872458a66b1f"
    let apiKeyMiddleware = APIKeyMiddleware(apiKey: apiKey)
    let client = try! Client(serverURL: Servers.Server1.url(), transport: URLSessionTransport(), middlewares: [apiKeyMiddleware])
    let viewModel = TabSelectionViewModel(client: client)
    MainView(viewModel: viewModel)
}
