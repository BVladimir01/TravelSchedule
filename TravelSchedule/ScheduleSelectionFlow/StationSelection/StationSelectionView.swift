//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


struct StationSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    
    private let stations: [Station]
    private let onStationSelection: (Station) -> ()
    
    private var displayedStations: [Station] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { station in
            return station.title.lowercased().contains(searchText.lowercased())
        }
    }
    
    init(stations: [Station], onStationSelection: @escaping (Station) -> ()) {
        self.stations = stations
        self.onStationSelection = onStationSelection
    }
    
    var body: some View {
        Group {
            if displayedStations.isEmpty {
                Text("Станция не найдена")
                    .foregroundStyle(.ypBlack)
                    .font(.system(size: 24, weight: .bold))
            } else {
                VStack {
                    ChevronItemListView(items: displayedStations, onItemSelection: { station in
                        onStationSelection(station)
                    })
                    Spacer()
                }
            }
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
    
}
