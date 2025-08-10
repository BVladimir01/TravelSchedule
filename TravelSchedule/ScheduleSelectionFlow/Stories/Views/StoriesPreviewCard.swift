//
//  StoriesPreviewCard.swift
//  TravelSchedule
//
//  Created by Vladimir on 10.08.2025.
//

import SwiftUI

struct StoriesPreviewCard: View {
    
    private let story: StoryPageContent
    private let hasNewContent: Bool
    
    init(story: StoryPageContent, hasNewContent: Bool) {
        self.story = story
        self.hasNewContent = hasNewContent
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 92, height: 140)
            Text(story.title)
                .lineLimit(3)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.ypWhiteUniversal)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.ypBlue, lineWidth: hasNewContent ? 4 : 0)
        }
    }
    
}


#Preview {
    Color.ypBlack
        .ignoresSafeArea()
        .overlay {
            StoriesPreviewCard(story: StoryPageContent(title: "Title 1", text: "Text 1", imageName: "Story1"), hasNewContent: true)
                .padding()
        }
}
