//
//  StoryPageView.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI


// MARK: - StoryPageView
struct StoryPageView: View {
    
    // MARK: - Private Properties
    
    private let story: StoryPageContent
    
    // MARK: - Initializer
    
    init(story: StoryPageContent) {
        self.story = story
    }
    
    // MARK: - Views
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Image(story.imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(edges: .horizontal)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
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
    
}


#Preview {
    StoryPageView(story: StoryPageContent(title: "Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 ",
                                          text: "Text 1 Text 1 Text 1 Text 1 Text 1 Text 1 Text 1 Text 1 ",
                                          imageName: "Story1"))
}
