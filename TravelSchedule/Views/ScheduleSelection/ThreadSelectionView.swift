//
//  ThreadSelectionView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//


import SwiftUI


struct ThreadSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private let originLocation: Location
    private let destinationLocation: Location
    
    init(originLocation: Location, destinationLocation: Location) {
        self.originLocation = originLocation
        self.destinationLocation = destinationLocation
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                titleLabel
                Spacer()
            }
            specifyTimeButton
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var titleLabel: some View {
        Text("\(originLocation.description ?? "") → \(destinationLocation.description ?? "")")
            .foregroundStyle(.ypBlack)
            .font(.system(size: 24, weight: .bold))
            .padding(16)
    }
    
    private var specifyTimeButton: some View {
        Button {
            
        } label: {
            Text("Уточнить время")
                .foregroundStyle(.ypWhite)
                .font(.system(size: 17, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ypBlue)
                }
        }
    }
    
}


#Preview {
    ThreadSelectionView(originLocation: Location(city: "Moscow",
                                                 station: "Kazanskiy"),
                        destinationLocation: Location(city: "SpB",
                                                      station: "Station number 3"))
}
