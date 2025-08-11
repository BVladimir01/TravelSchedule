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
    
    init(client: APIProtocol) {
        scheduleNavigationVM = ScheduleNavigationViewModel(client: client)
    }
    
}

extension TabSelectionViewModel {
    enum Tab {
        case scheduleSelection, settings
    }
}
