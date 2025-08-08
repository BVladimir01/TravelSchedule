//
//  StoriesMainVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI


final class StoriesMainVM: ObservableObject {    
    
    private let storiesProvider: StoriesProvider
    
    var authors: [StoryAuthor] {
        storiesProvider.authors
    }
    
    var stories: [Story] {
        storiesProvider.stories
    }
    
    func watch(story: Story) {
        storiesProvider.watch(story: story)
    }
    
    init(storiesProvider: StoriesProvider) {
        self.storiesProvider = storiesProvider
    }
    
    convenience init() {
        self.init(storiesProvider: StoriesProvider.shared)
    }
    
}
