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
    
    private let stations: [String]
    private let onStationSelection: (String) -> ()
    
    private var displayedStations: [String] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { $0.description.lowercased().contains(searchText.lowercased()) }
    }
    
    init(stations: [String], onStationSelection: @escaping (String) -> Void) {
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
