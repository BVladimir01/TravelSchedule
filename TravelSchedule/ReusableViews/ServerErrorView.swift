//
//  ServerErrorView.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

import SwiftUI


struct ServerErrorView: View {
    var body: some View {
        VStack {
            Image(.serverError)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
            Text("Ошибка сервера")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
        }
    }
}
