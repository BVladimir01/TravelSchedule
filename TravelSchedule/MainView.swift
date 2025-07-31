//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Vladimir on 23.07.2025.
//

import SwiftUI
import OpenAPIURLSession

struct MainView: View {
    
    @StateObject private var viewModel = ScheduleNavigationViewModel()
    
    @State private var selectedTab: Tab = .schedule
    @Environment(\.colorScheme) private var colorScheme
    
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
            ScheduleNavigationRootView(viewModel: viewModel)
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


extension MainView {
    private enum Tab {
        case schedule, settings
    }
}

#Preview {
    MainView()
}
