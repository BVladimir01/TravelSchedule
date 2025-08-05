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
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            mainContentView
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
    
    @ViewBuilder
    private var mainContentView: some View {
        switch loadingState {
        case .idle:
            EmptyView()
        case .loading:
            loaderView
        case .success:
            if displayedCities.isEmpty {
                listEmptyView
            } else {
                scrollableCitiesView
            }
        case .error(let dataFetchingError):
            ErrorView(errorType: dataFetchingError)
        }
    }

    private var listEmptyView: some View {
        Text("Город не найден")
            .foregroundStyle(.ypBlack)
            .font(.system(size: 24, weight: .bold))
    }
    
    private var scrollableCitiesView: some View {
        ScrollView {
            VStack(spacing: .zero) {
                ChevronItemListView(items: displayedCities, onItemSelection: { city in
                    onCitySelection(city)
                })
                Spacer()
            }
        }
    }
    
    private var loaderView: some View {
        ProgressView()
            .tint(.ypBlack)
            .scaleEffect(2)
    }
}
