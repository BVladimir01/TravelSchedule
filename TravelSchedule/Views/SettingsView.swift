//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


struct SettingsView: View {
    
    private let stubImageSize: Double = 223
    
    var body: some View {
        Image(.serverError)
            .resizable()
            .frame(width: stubImageSize, height: stubImageSize)
            .padding(.bottom, 16)
        Text("Ошибка Сервера")
            .font(.system(size: 24, weight: .bold))
    }
    
}


#Preview {
    SettingsView()
}
