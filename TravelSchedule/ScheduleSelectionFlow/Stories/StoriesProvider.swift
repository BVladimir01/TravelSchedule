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
    
    private var stories: [Story] = []
    private var authors: [StoryAuthor] = []
    
    func watch(story: Story) -> Bool{
        guard let index = stories.firstIndex(where: { $0.id == story.id} ) else {
            return false
        }
        stories[index] = Story(id: story.id, authorID: story.authorID, content: story.content, watched: true)
        return true
    }
    
    func fetchStories() -> [Story] {
        stories
    }
    
    func author(with id: StoryAuthor.ID) -> StoryAuthor? {
        authors.first(where: { $0.id == id})
    }
    
}
