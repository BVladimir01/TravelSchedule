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
    
    private let cities: [String]
    private let onCitySelection: (String) -> ()
    
    private var displayedCities: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.description.lowercased().contains(searchText.lowercased()) }
    }
    
    init(cities: [String], onCitySelection: @escaping (String) -> Void) {
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
        .searchable(text: $searchText, placement: .automatic, prompt: Text("Введите запрос"))
    }

}
