//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI

// MARK: - CitySelectionView
struct CitySelectionView: View {
    
    // MARK: - Private Properties - State
    
    @State private var searchText: String = ""
    
    // MARK: - Private Properties
    
    @Environment(\.dismiss) private var dismiss
    private var loadingState: DataLoadingState
    private let cities: [City]
    private let onCitySelection: (City) -> ()
    
    private var displayedCities: [City] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { city in
            return city.title.lowercased().contains(searchText.lowercased())
        }
    }
    
    // MARK: - Initializers
    
    init(cities: [City], loadingState: DataLoadingState, onCitySelection: @escaping (City) -> ()) {
        self.cities = cities
        self.onCitySelection = onCitySelection
        self.loadingState = loadingState
    }
    
    // MARK: - Views
    var body: some View {
        Group {
            switch loadingState {
            case .idle:
                EmptyView()
            case .loading:
                loaderView
            case .success:
                if displayedCities.isEmpty {
                    listEmptyView
                } else {
                    contentView
                }
            case .error(let error):
                errorView(for: error)
            }
        }
        .navigationTitle(Text("Выбор города"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .searchable(text: $searchText, placement: .automatic, prompt: Text("Введите запрос"))
    }

    private var listEmptyView: some View {
        Text("Город не найден")
            .foregroundStyle(.ypBlack)
            .font(.system(size: 24, weight: .bold))
    }
    
    private var contentView: some View {
        VStack {
            ChevronItemListView(items: displayedCities, onItemSelection: { city in
                onCitySelection(city)
            })
            Spacer()
        }
    }
    
    private var loaderView: some View {
        ProgressView()
            .tint(.ypBlack)
            .scaleEffect(2)
    }
    
    @ViewBuilder
    private func errorView(for error: DataFetchingError) -> some View {
        switch error {
        case .noInternetError:
            NoInternetErrorView()
        case .serverError(error: let error):
            ServerErrorView()
        case .parsingError:
            ServerErrorView()
        }
    }
    
}
