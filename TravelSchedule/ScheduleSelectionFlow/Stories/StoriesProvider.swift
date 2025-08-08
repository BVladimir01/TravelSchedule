//
//  StoriesProvider.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import Foundation

final class StoriesProvider {
    
    static let shared = StoriesProvider()
    
    private init() { }
    
    let stories: [Story] = []
    let authors: [StoryAuthor] = []
    private(set) var watchedStories: Set<UUID> = []
    
    func watch(story: Story) {
        watchedStories.insert(story.id)
    }
    
}
