//
//  NavigationBackButton.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import SwiftUI

struct NavigationBackButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(.back)
        }
        .tint(.ypBlack)
    }
    
}
