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
        ZStack(alignment: .bottom) {
            Image(story.imageName)
                .resizable()
                .scaledToFill()
            HStack(spacing: .zero) {
                Text(story.title)
                    .lineLimit(3)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypWhiteUniversal)
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.ypBlue, lineWidth: hasNewContent ? 4 : 0)
        }
        .aspectRatio(92/140, contentMode: .fit)
    }
    
}


#Preview {
    Color.ypBlack
        .ignoresSafeArea()
        .overlay {
            StoriesPreviewCard(story: StoryPageContent(title: "Title 1", text: "Text 1", imageName: "Story1"), hasNewContent: true)
                .frame(width: 200)
                .padding()
        }
}
