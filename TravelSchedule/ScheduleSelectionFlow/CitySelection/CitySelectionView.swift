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
    
    private let cities: [City]
    private let onCitySelection: (City) -> ()
    
    private var displayedCities: [City] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { city in
            guard let title = city.title else { return true }
            return title.lowercased().contains(searchText.lowercased())
        }
    }
    
    init(cities: [City], onCitySelection: @escaping (City) -> ()) {
        self.cities = cities
        self.onCitySelection = onCitySelection
    }
    
    var body: some View {
        Group {
            if displayedCities.isEmpty {
                Text("Город не найден")
                    .foregroundStyle(.ypBlack)
                    .font(.system(size: 24, weight: .bold))
            } else {
                VStack {
                    ChevronItemListView(items: displayedCities, onItemSelection: { city in
                        onCitySelection(city)
                    })
                    Spacer()
                }
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

}
