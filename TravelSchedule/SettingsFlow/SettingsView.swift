//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


struct SettingsView: View {

    // MARK: - Private Properties
    
    private let stubImageSize: Double = 223
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            ErrorView(errorType: .serverError(description: nil))
        }
    }
    
}


#Preview {
    SettingsView()
}
