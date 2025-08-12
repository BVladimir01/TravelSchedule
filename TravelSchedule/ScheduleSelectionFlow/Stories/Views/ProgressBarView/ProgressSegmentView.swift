//
//  ProgressSegmentView.swift
//  StoriesViewPractice
//
//  Created by Vladimir on 06.08.2025.
//

import SwiftUI


// MARK: - ProgressSegmentView
struct ProgressSegmentView: View {
    
    // MARK: - Private Properties
    
    private let progress: Double
    
    // MARK: - Initializer
    
    init(progress: Double) {
        self.progress = progress
    }
    
    // MARK: - Views
    
    var body: some View {
        GeometryReader { geometry in
            let radius = geometry.size.height
            let width: Double = progress <= 0 ? 0 :
                radius + max(min(progress, 1), 0)*(geometry.size.width - radius)
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: radius)
                    .foregroundStyle(.ypWhiteUniversal)
                RoundedRectangle(cornerRadius: radius)
                    .foregroundStyle(.ypBlue)
                    .frame(width: width)
            }
        }
    }
    
}


#Preview {
    Color.black.overlay {
        ProgressSegmentView(progress: 0.001)
            .frame(width: 100, height: 10)
    }
}
