//
//  ScheduleNavigationRootView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


struct ScheduleNavigationRootView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    @State private var path: [Destination] = []
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                locationsSelector
                    .padding(.top, 20)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                if viewModel.searchIsEnabled {
                    searchButton
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .city(selection: let selection):
                    Text("City selection for \(selection)")
                case .station(selection: let selection):
                    Text("Station selection for \(selection)")
                case .thread:
                    Text("Thread selection")
                }
                
            }
            .navigationTitle("TravelSchedule")
            Spacer()
        }
    }
    
    private var locationsSelector: some View {
        HStack(spacing: 16) {
            textFields
            changeButton
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
                    .fill(.ypWhite)
                    .frame(height: 96)
            }
            .border(.blue)
    }
    
    private var originTextField: some View {
        NavigationLink(value: Destination.city(selection: .origin)) {
            HStack {
                Text(viewModel.originLocation?.description ?? "Откуда")
                    .foregroundStyle(viewModel.originLocation == nil ? Color.ypGray : Color.ypBlack)
                Spacer()
            }
        }
    }
    
    private var destinationTextField: some View {
        NavigationLink(value: Destination.city(selection: .destination)) {
            HStack {
                Text(viewModel.destinationLocation?.description ?? "Куда")
                    .foregroundStyle(viewModel.destinationLocation == nil ? Color.ypGray : Color.ypBlack)
                Spacer()
            }
        }
    }
    
    private var changeButton: some View {
        Button { } label: {
            Circle()
                .fill(.ypWhite)
                .frame(width: 36, height: 36)
                .overlay {
                    Image(.сhange)
                        .tint(.ypBlue)
                }
        }
    }
    
    private var searchButton: some View {
        Button { } label: {
            Text("Найти")
                .padding(.vertical, 20)
                .padding(.horizontal, 47.5)
                .foregroundStyle(.ypWhite)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ypBlue)
                }
        }
    }
    
}


#Preview {
    ScheduleNavigationRootView(viewModel: ViewModel())
}
