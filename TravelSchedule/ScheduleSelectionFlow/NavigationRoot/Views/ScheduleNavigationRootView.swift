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
    
    // MARK: - Initializers
    
    init(viewModel: ScheduleNavigationViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Views
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            content
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
                    if let threadsVM = viewModel.threadSelectionVM {
                        ThreadSelectionView(viewModel: threadsVM)
                    }
                }
            }
            .navigationTitle("TravelSchedule")
        }
    }
    
    private var content: some View {
        VStack(spacing: 20) {
            StoriesPreview(viewModel: viewModel.storiesPreviewVM)
                .frame(height: 140)
                .padding(.vertical, 24)
            VStack(spacing: 16) {
                stationsSelector
                if viewModel.searchIsEnabled {
                    searchThreadsButton
                }
            }
            .padding(.horizontal, 16)
            Spacer()
        }
        .fullScreenCover(isPresented: $viewModel.isShowingStories) {
            if let vm = viewModel.storiesFlowVM {
                StoriesFlowView(viewModel: vm)
            }
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
    
    private var stationsSelector: some View {
        StationsSelectorView(origin: viewModel.originStation?.title, destination: viewModel.destinationStation?.title) { event in
            switch event {
            case .originTapped:
                viewModel.showCitySelectionView(for: .origin)
            case .destinationTapped:
                viewModel.showCitySelectionView(for: .destination)
            case .swapTapped:
                viewModel.swapLocationTypes()
            }
        }
    }
    
    private var searchThreadsButton: some View {
        Button {
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
