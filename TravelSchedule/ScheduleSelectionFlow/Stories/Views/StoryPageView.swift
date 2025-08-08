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
            Color.ypBlack.ignoresSafeArea()
            Image(story.imageName)
                .resizable()
                .scaledToFit()
            VStack(spacing: 16) {
                Text(story.title)
                    .foregroundStyle(.ypWhiteUniversal)
                    .font(.system(size: 34, weight: .bold))
                Text(story.text)
                    .foregroundStyle(.ypWhiteUniversal)
                    .font(.system(size: 20, weight: .regular))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
    }
    
}
