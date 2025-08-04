//
//  ScheduleNavigationRootView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI



struct ScheduleNavigationRootView: View {
    
    @ObservedObject private var viewModel: ScheduleNavigationViewModel
    @StateObject private var threadsViewModel: ThreadsViewModel
    
    
    init(viewModel: ScheduleNavigationViewModel, client: APIProtocol) {
        self.viewModel = viewModel
        _threadsViewModel = StateObject(wrappedValue: ThreadsViewModel(client: client))
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
                        .onAppear {
                            viewModel.fetchCitiesAndStations()
                        }
                case .stationSelection(locationType: let locationType):
                    stationSelectionPage(for: locationType)
                case .threadSelection:
                    if let origin = viewModel.originStation,
                       let destination = viewModel.destinationStation {
                        ThreadSelectionView(origin: origin,
                                            destination: destination,
                                            viewModel: threadsViewModel)
                    }
                }
            }
            .navigationTitle("TravelSchedule")
            Spacer()
        }
    }
    
    private func citySelectionPage(for locationType: LocationType) -> some View {
        CitySelectionView(cities: viewModel.cities,
                          loadingState: viewModel.loadingState,
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
    }
    
    private var originTextField: some View {
        Button {
            viewModel.searchCity(for: .origin)
        } label: {
            HStack {
                Text(viewModel.description(for: .origin) ?? "Откуда")
                    .foregroundStyle(viewModel.isDefined(locationType: .origin) ? Color.ypBlack : Color.ypGray)
                    .lineLimit(1)
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
                    .lineLimit(1)
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
//    let apiKey = "f5fad011-aeea-4dab-a7a8-872458a66b1f"
//    let apiKeyMiddleware = APIKeyMiddleware(apiKey: apiKey)
//    let client = try! Client(serverURL: Servers.Server1.url(), transport: URLSessionTransport(), middlewares: [apiKeyMiddleware])
//    ScheduleNavigationRootView(viewModel: ScheduleNavigationViewModel())
}
