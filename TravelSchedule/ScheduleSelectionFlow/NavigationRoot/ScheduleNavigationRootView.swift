//
//  ScheduleNavigationRootView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


struct ScheduleNavigationRootView: View {
    
    @ObservedObject private var viewModel: ScheduleNavigationViewModel
    
    init(viewModel: ScheduleNavigationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack {
                locationsSelector
                    .padding(.top, 20)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                if viewModel.searchIsEnabled {
                    searchThreadsButton
                }
            }
            .navigationDestination(for: PageType.self) { pageType in
                switch pageType {
                case .citySelection(locationType: let locationType):
                    citySelectionPage(for: locationType)
                case .stationSelection(locationType: let locationType):
                    stationSelectionPage(for: locationType)
                case .threadSelection:
                    if let origin = viewModel.location(of: .origin),
                       let destination = viewModel.location(of: .destination) {
                        ThreadSelectionView(origin: origin,
                                            destination: destination)
                    }
                }
            }
            .navigationTitle("TravelSchedule")
            Spacer()
        }
    }
    
    private func citySelectionPage(for locationType: LocationType) -> some View {
        CitySelectionView(cities: viewModel.cities,
                          onCitySelection: { city in
            viewModel.selectCity(city, for: locationType)
        })
    }
    
    @ViewBuilder
    private func stationSelectionPage(for locationType: LocationType) -> some View {
        if let selectedCity = viewModel.city(of: locationType) {
            StationSelectionView(stations: viewModel.stations(of: selectedCity), onStationSelection: { station in
                viewModel.selectStation(station, for: locationType)
            })
        } else {
            EmptyView()
        }
    }
    
    private var locationsSelector: some View {
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
                    .fill(.ypWhite)
                    .frame(height: 96)
            }
            .border(.blue)
    }
    
    private var originTextField: some View {
        Button {
            viewModel.searchCity(for: .origin)
        } label: {
            HStack {
                Text(viewModel.description(for: .origin) ?? "Откуда")
                    .foregroundStyle(viewModel.isDefined(locationType: .origin) ? Color.ypBlack : Color.ypGray)
                Spacer()
            }
        }
    }
    
    private var destinationTextField: some View {
        Button {
            viewModel.searchCity(for: .destination)
        } label: {
            HStack {
                Text(viewModel.description(for: .destination) ?? "Куда")
                    .foregroundStyle(viewModel.isDefined(locationType: .destination) ? Color.ypBlack : Color.ypGray)
                Spacer()
            }
        }
    }
    
    private var swapButton: some View {
        Button {
            viewModel.swapLocationTypes()
        } label: {
            Circle()
                .fill(.ypWhite)
                .frame(width: 36, height: 36)
                .overlay {
                    Image(.сhange)
                        .tint(.ypBlue)
                }
        }
    }
    
    private var searchThreadsButton: some View {
        Button {
            viewModel.searchThreads()
        } label: {
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
    ScheduleNavigationRootView(viewModel: ScheduleNavigationViewModel())
}
