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
        VStack {
            ChevronItemListView(items: displayedCities, onItemSelection: { city in
                onCitySelection(city)
            })
            Spacer()
        }
        .navigationTitle(Text("Выбор города"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .searchable(text: $searchText, placement: .automatic, prompt: Text("Введите запрос"))
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(.back)
        }
        .tint(.ypBlack)
    }

}
