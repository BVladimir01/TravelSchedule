//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


// MARK: - StationSelectionView
struct StationSelectionView: View {
    
    // MARK: - Private Properties - State
    
    @State private var searchText: String = ""
    
    // MARK: - Private Properties
    
    @Environment(\.dismiss) private var dismiss
    private let stations: [Station]
    private let onStationSelection: (Station) -> ()
    
    private var displayedStations: [Station] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { station in
            return station.title.lowercased().contains(searchText.lowercased())
        }
    }
    
    // MARK: - Initializers
    
    init(stations: [Station], onStationSelection: @escaping (Station) -> ()) {
        self.stations = stations
        self.onStationSelection = onStationSelection
    }
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            mainContentView
        }
        .navigationTitle(Text("Выбор станции"))
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
        if displayedStations.isEmpty {
            listEmptyView
        } else {
            scrollableStationsView
        }
    }
    
    private var listEmptyView: some View {
        Text("Станция не найдена")
            .foregroundStyle(.ypBlack)
            .font(.system(size: 24, weight: .bold))
    }
    
    private var scrollableStationsView: some View {
        ScrollView {
            VStack(spacing: .zero) {
                ChevronItemListView(items: displayedStations, onItemSelection: { station in
                    onStationSelection(station)
                })
                Spacer()
            }
        }
    }
    
}
