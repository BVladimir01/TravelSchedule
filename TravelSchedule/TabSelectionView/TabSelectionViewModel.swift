//
//  TabSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 11.08.2025.
//

import SwiftUI

// MARK: - TabSelectionViewModel

final class TabSelectionViewModel: ObservableObject {
    
    // MARK: - Internal Properties
    
    @Published var currentTab: Tab = .scheduleSelection
    let scheduleNavigationVM: ScheduleNavigationViewModel
    
    // MARK: - Initializer
    
    init(client: APIProtocol) {
        scheduleNavigationVM = ScheduleNavigationViewModel(client: client)
    }
    
}


// MARK: - Tab
extension TabSelectionViewModel {
    enum Tab {
        case scheduleSelection, settings
    }
}
