//
//  ErrorView.swift
//  TravelSchedule
//
//  Created by Vladimir on 05.08.2025.
//

import SwiftUI

struct ErrorView: View {
    
    private let errorType: DataFetchingError
    
    private var image: Image {
        switch errorType {
        case .parsingError:
            Image(.serverError)
        case .serverError:
            Image(.serverError)
        case .noInternetError:
            Image(.noInternet)
        }
    }
    
    private var description: String {
        switch errorType {
        case .parsingError:
            "Ошибка сервера"
        case .serverError:
            "Ошибка сервера"
        case .noInternetError:
            "Нет интернета"
        }
    }
    
    init(errorType: DataFetchingError) {
        self.errorType = errorType
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
            Text(description)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
        }
    }
    
}
