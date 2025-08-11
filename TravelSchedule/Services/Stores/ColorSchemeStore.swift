//
//  ColorModeStore.swift
//  TravelSchedule
//
//  Created by Vladimir on 11.08.2025.
//

import SwiftUI


final class ColorSchemeStore: ObservableObject {
    
    static let shared = ColorSchemeStore()
    
    @AppStorage(storageKey) var isDarkTheme = false
    
    private static let storageKey = "isDarkTheme"
    
    private init() { }
    
}
