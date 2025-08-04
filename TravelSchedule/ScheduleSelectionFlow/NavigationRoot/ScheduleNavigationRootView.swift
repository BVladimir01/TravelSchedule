//
//  ScheduleNavigationRootView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


// MARK: - ScheduleNavigationRootView
struct ScheduleNavigationRootView: View {
    
    
    // MARK: - Private Properties - State
    
    @ObservedObject private var viewModel: ScheduleNavigationViewModel
    
    // MARK: - Private Properties - State
    
    @StateObject private var threadsViewModel: ThreadsViewModel
    
    // MARK: - Initializers
    
    init(viewModel: ScheduleNavigationViewModel, client: APIProtocol) {
        self.viewModel = viewModel
        _threadsViewModel = StateObject(wrappedValue: ThreadsViewModel(client: client))
    }
    
    // MARK: - Views
    
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
                Spacer()
            }
            .background(.ypWhite)
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
                    ThreadSelectionView(viewModel: threadsViewModel)
                }
            }
            .navigationTitle("TravelSchedule")
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
            StationSelectionView(stations: viewModel.stations(of: selectedCity),
                                 onStationSelection: { station in
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
                    .fill(.ypWhiteUniversal)
                    .frame(height: 96)
            }
    }
    
    private var originTextField: some View {
        Button {
            viewModel.showCitySelectionView(for: .origin)
        } label: {
            HStack {
                Text(viewModel.originStation?.title ?? "Откуда")
                    .foregroundStyle(viewModel.isDefined(locationType: .origin) ? Color.ypBlackUniversal : Color.ypGray)
                    .lineLimit(1)
                Spacer()
            }
        }
    }
    
    private var destinationTextField: some View {
        Button {
            viewModel.showCitySelectionView(for: .destination)
        } label: {
            HStack {
                Text(viewModel.destinationStation?.title ?? "Куда")
                    .foregroundStyle(viewModel.isDefined(locationType: .destination) ? Color.ypBlackUniversal : Color.ypGray)
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
                .fill(.ypWhiteUniversal)
                .frame(width: 36, height: 36)
                .overlay {
                    Image(.сhange)
                        .tint(.ypBlue)
                }
        }
    }
    
    private var searchThreadsButton: some View {
        Button {
            guard let origin = viewModel.originStation,
                  let destination = viewModel.destinationStation
            else {
                return
            }
            threadsViewModel.configure(origin: origin, destination: destination)
            viewModel.showThreadsSelectionView()
        } label: {
            Text("Найти")
                .padding(.vertical, 20)
                .padding(.horizontal, 47.5)
                .foregroundStyle(.ypWhiteUniversal)
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
