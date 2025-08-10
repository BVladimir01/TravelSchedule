//
//  StoriesPreview.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI

struct StoriesPreview: View {
    
    @ObservedObject private var vm: StoriesPreviewVM

    init(viewModel: StoriesPreviewVM) {
        vm = viewModel
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(vm.authorsWithNewContent, id: \.id) { author in
                    renderedPreviewCard(for: author, withNewContent: true)
                }
                ForEach(vm.authorsWithoutNewContent, id: \.id) { author in
                    renderedPreviewCard(for: author, withNewContent: false)
                }
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden)
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



#Preview {
    
    StoriesPreview(viewModel: StoriesPreviewVM(storiesStore: .shared))
        .frame(height: 200)
}
