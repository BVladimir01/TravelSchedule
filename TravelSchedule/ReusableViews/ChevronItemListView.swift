//
//  ChevronItemListView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


// MARK: - ChevronItemListView
struct ChevronItemListView<Item: CustomStringConvertible & Hashable>: View {
    
    // MARK: - Private Properties
    
    private let items: [Item]
    private let onItemSelection: (Item) -> ()
    
    // MARK: - Initializers
    
    init(items: [Item], onItemSelection: @escaping (Item) -> Void) {
        self.items = items
        self.onItemSelection = onItemSelection
    }
    
    // MARK: - Views
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items, id: \.self) { item in
                    Button {
                        onItemSelection(item)
                    } label: {
                        rowView(for: item)
                    }
                    .padding(.horizontal, 16)
                }
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
    
}
