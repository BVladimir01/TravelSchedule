//
//  ProgressBar.swift
//  StoriesViewPractice
//
//  Created by Vladimir on 06.08.2025.
//

import SwiftUI


struct ProgressBar: View {
    
    private let totalSegmentsNumber: Int
    private let currentSegmentIndex: Int
    private let spacing: Double
    private let currentProgress: Double
    
    init(totalSegmentsNumber: Int, currentSegmentIndex: Int, spacing: Double, currentProgress: Double) {
        self.totalSegmentsNumber = totalSegmentsNumber
        self.currentSegmentIndex = currentSegmentIndex
        self.spacing = spacing
        self.currentProgress = currentProgress
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<totalSegmentsNumber, id: \.self) { index in
                progressSegment(at: index)
            }
        }
    }
    
    private func progressSegment(at index: Int) -> some View {
        if index < currentSegmentIndex {
            ProgressSegmentView(progress: 1)
        } else if index == currentSegmentIndex {
            ProgressSegmentView(progress: currentProgress)
        } else {
            ProgressSegmentView(progress: 0)
        }
    }
    
}


#Preview {
    Color.black
        .overlay {
            ProgressBar(totalSegmentsNumber: 6,
                        currentSegmentIndex: 3,
                        spacing: 10,
                        currentProgress: 0.5)
            .frame(height: 10)
        }
}
