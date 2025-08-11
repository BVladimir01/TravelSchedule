//
//  TabSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 11.08.2025.
//

import SwiftUI

final class TabSelectionViewModel: ObservableObject {
    
    @Published var currentTab: Tab = .scheduleSelection
    let scheduleNavigationVM: ScheduleNavigationViewModel
    let settingsVM: SettingsViewModel
    
    init(client: APIProtocol) {
        scheduleNavigationVM = ScheduleNavigationViewModel(client: client)
        settingsVM = SettingsViewModel(themeStore: .shared)
    }
    
}

extension TabSelectionViewModel {
    enum Tab {
        case scheduleSelection, settings
    }
}
