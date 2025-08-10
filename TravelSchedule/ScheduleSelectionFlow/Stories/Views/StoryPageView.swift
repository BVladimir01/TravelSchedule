//
//  StoryPageView.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI

struct StoryPageView: View {
    
    private let story: StoryPageContent
    
    init(story: StoryPageContent) {
        self.story = story
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.ypBlackUniversal.ignoresSafeArea()
            Image(story.imageName)
                .resizable()
                .scaledToFit()
            HStack(spacing: .zero) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(story.title)
                        .foregroundStyle(.ypWhiteUniversal)
                        .font(.system(size: 34, weight: .bold))
                        .lineLimit(2)
                    Text(story.text)
                        .foregroundStyle(.ypWhiteUniversal)
                        .font(.system(size: 20, weight: .regular))
                        .lineLimit(2)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
    }
    
}


#Preview {
    StoryPageView(story: StoryPageContent(title: "Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 ",
                                          text: "Text 1 Text 1 Text 1 Text 1 Text 1 Text 1 Text 1 Text 1 ",
                                          imageName: "Story1"))
}
