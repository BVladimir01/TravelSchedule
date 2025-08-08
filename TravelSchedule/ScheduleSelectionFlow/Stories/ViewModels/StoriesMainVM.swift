//
//  StoriesMainVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI


final class StoriesMainVM: ObservableObject {    
    
    private let storiesProvider: StoriesProvider
    
    @Published private var stories: [Story]
    
    var authors: [StoryAuthor] {
        let authorIDs = Set<StoryAuthor.ID>(stories.map { $0.authorID })
        return authorIDs.compactMap { storiesProvider.author(with: $0) }
    }
    
    func watch(story: Story) {
        guard let index = stories.firstIndex(where: { $0.id == story.id }),
              storiesProvider.watch(story: story) else {
            return
        }
        stories[index] = Story(id: story.id,
                               authorID: story.authorID,
                               content: story.content,
                               watched: true)
    }
    
    
    init(storiesProvider: StoriesProvider) {
        self.storiesProvider = storiesProvider
        self.stories = storiesProvider.fetchStories()
        
    }
    
    convenience init() {
        self.init(storiesProvider: StoriesProvider.shared)
    }
    
}
