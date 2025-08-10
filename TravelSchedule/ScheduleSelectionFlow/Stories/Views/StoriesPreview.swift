//
//  StoriesPreview.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI

struct StoriesPreview: View {
    
    private let vm: StoriesPreviewVM

    init(viewModel: StoriesPreviewVM) {
        vm = viewModel
    }
    
    var body: some View {
        ScrollView {
            HStack(spacing: 12) {
                ForEach(vm.authorsWithNewContent, id: \.id) { author in
                    renderedPreviewCard(for: author, withNewContent: true)
                }
                ForEach(vm.authorsWithoutNewContent, id: \.id) { author in
                    renderedPreviewCard(for: author, withNewContent: false)
                }
            }
        }
    }
    
    private func renderedPreviewCard(for author: StoryAuthor, withNewContent: Bool) -> some View {
        let storyContent = vm.previewStory(of: author)?.content ?? StoryPageContent(title: "", text: "", imageName: "")
        return StoriesPreviewCard(story: storyContent, hasNewContent: withNewContent)
            .onTapGesture {
                vm.authorTapped(author)
            }
    }
    
}


extension StoriesPreview {
    enum Event {
        case authorTapped(author: StoryAuthor)
    }
}
