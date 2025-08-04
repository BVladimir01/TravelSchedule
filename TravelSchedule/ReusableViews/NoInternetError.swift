//
//  NoInternetError.swift
//  TravelSchedule
//
//  Created by Vladimir on 04.08.2025.
//

import SwiftUI

struct NoInternetError: View {
    var body: some View {
        VStack {
            Image(.noInternet)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
            Text("Нет интернета")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
        }
    }
}
