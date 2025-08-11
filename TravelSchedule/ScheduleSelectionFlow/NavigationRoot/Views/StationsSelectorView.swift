//
//  StationsSelectorView.swift
//  TravelSchedule
//
//  Created by Vladimir on 11.08.2025.
//

import SwiftUI


// MARK: - StationsSelectorView
struct StationsSelectorView: View {
    
    // MARK: - Private Properties
    
    private let origin: String?
    private let destination: String?
    private let onEvent: (Event) -> ()
    
    // MARK: - Initializer
    
    init(origin: String?, destination: String?, onEvent: @escaping (Event) -> Void) {
        self.origin = origin
        self.destination = destination
        self.onEvent = onEvent
    }
    
    // MARK: - Views
    
    var body: some View {
        HStack(spacing: 16) {
            textFields
            swapButton
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ypBlue)
        }
    }
    
    
    private var textFields: some View {
            VStack(spacing: 28) {
                originTextField
                destinationTextField
            }
            .padding(.leading, 16)
            .padding(.trailing, 13)
            .padding(.vertical, 14)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ypWhiteUniversal)
                    .frame(height: 96)
            }
    }
    
    private var originTextField: some View {
        Button {
            onEvent(.originTapped)
        } label: {
            HStack {
                Text(origin ?? "Откуда")
                    .foregroundStyle(isDefined(origin) ? Color.ypBlackUniversal : Color.ypGray)
                    .lineLimit(1)
                Spacer()
            }
        }
    }
    
    private var destinationTextField: some View {
        Button {
            onEvent(.destinationTapped)
        } label: {
            HStack {
                Text(destination ?? "Куда")
                    .foregroundStyle(isDefined(destination) ? Color.ypBlackUniversal : Color.ypGray)
                    .lineLimit(1)
                Spacer()
            }
        }
    }
    
    private var swapButton: some View {
        Button {
            onEvent(.swapTapped)
        } label: {
            Circle()
                .fill(.ypWhiteUniversal)
                .frame(width: 36, height: 36)
                .overlay {
                    Image(.сhange)
                        .tint(.ypBlue)
                }
        }
    }
    
    // MARK: - Private Methods
    
    private func isDefined(_ place: String?) -> Bool {
        if place == nil { false } else { true }
    }
    
}


// MARK: Event
extension StationsSelectorView {
    enum Event {
        case originTapped, destinationTapped, swapTapped
    }
}
