//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI

struct CitySelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    private var loadingState: CitiesLoadingState
    
    private let cities: [City]
    private let onCitySelection: (City) -> ()
    
    private var displayedCities: [City] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { city in
            guard let title = city.title else { return true }
            return title.lowercased().contains(searchText.lowercased())
        }
    }
    
    init(cities: [City], loadingState: CitiesLoadingState, onCitySelection: @escaping (City) -> ()) {
        self.cities = cities
        self.onCitySelection = onCitySelection
        self.loadingState = loadingState
    }
    
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
            case .error:
                errorView
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
    
    private var errorView: some View {
        ServerErrorView()
    }
    
}
