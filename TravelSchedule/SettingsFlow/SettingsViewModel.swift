//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 11.08.2025.
//

import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject {
    
    @Published var isUsingDarkTheme: Bool
    @Published var isPresentingUserAgreement =  false
    
    private let themeStore: ColorSchemeStore
    private var cancellable: Cancellable?
    
    init(themeStore: ColorSchemeStore) {
        self.themeStore = themeStore
        isUsingDarkTheme = themeStore.isDarkTheme
        bindPublishedVarToStore()
    }
    
    private func bindPublishedVarToStore() {
        cancellable = $isUsingDarkTheme
            .receive(on: DispatchQueue.main)
            .assign(to: \.isDarkTheme, on: themeStore)
    }
    
}
