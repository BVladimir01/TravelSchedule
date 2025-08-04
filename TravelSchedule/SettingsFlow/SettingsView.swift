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
            VStack {
                Image(.serverError)
                    .resizable()
                    .frame(width: stubImageSize, height: stubImageSize)
                    .padding(.bottom, 16)
                Text("Ошибка Сервера")
                    .font(.system(size: 24, weight: .bold))
            }
        }
    }
    
}


#Preview {
    SettingsView()
}
