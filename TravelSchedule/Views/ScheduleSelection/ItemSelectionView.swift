//
//  ItemSelectionView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


struct ItemSelectionView<Item: CustomStringConvertible & Hashable>: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    
    private let destinationType: Destination
    private let items: [Item]
    private let onItemSelection: (Item) -> ()
    
    private var displayedItems: [Item] {
        guard !searchText.isEmpty else { return items }
        return items.filter { $0.description.lowercased().contains(searchText.lowercased()) }
    }
    
    init(destinationType: Destination, items: [Item], onItemSelection: @escaping (Item) -> ()) {
        self.destinationType = destinationType
        self.items = items
        self.onItemSelection = onItemSelection
    }
    
    var body: some View {
        VStack {
            itemsList
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
    
    private var itemsList: some View {
        VStack {
            ForEach(displayedItems, id: \.self) { item in
                Button {
                    onItemSelection(item)
                } label: {
                    rowView(for: item)
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    private func rowView(for item: Item) -> some View {
        HStack {
            Text(item.description)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.ypBlack)
                .padding(.vertical, 19)
            Spacer()
            Image(.chevron)
                .foregroundStyle(.ypBlack)
                .padding(.vertical, 18)
        }
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
