//
//  ColorModeStore.swift
//  TravelSchedule
//
//  Created by Vladimir on 11.08.2025.
//

import SwiftUI


final class ColorSchemeStore {
    
    var isDarkTheme: Bool {
        get {
            isDarkThemeStored
        }
        set {
            isDarkThemeStored = newValue
        }
    }
    
    static let shared = ColorSchemeStore()
    
    @AppStorage(storageKey) private var isDarkThemeStored = false
    
    private static let storageKey = "isDarkTheme"
    
    private init() { }
    
}
