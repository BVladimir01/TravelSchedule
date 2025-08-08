//
//  StoriesPreviewVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI


final class StoriesPreviewVM: ObservableObject {
    
    private let authors: [StoryAuthor]
    private let stories: [Story]
    private let watchedStories: Set<UUID>
    private let onEvent: (Event) -> ()
    
    init(authors: [StoryAuthor], stories: [Story], watchedStories: Set<UUID>, onEvent: @escaping (Event) -> Void) {
        self.authors = authors
        self.stories = stories
        self.watchedStories = watchedStories
        self.onEvent = onEvent
    }
    
    func authorTapped(_ author: StoryAuthor) {
        onEvent(.authorTapped(author: author))
    }
    
    enum Event {
        case authorTapped(author: StoryAuthor)
    }
    
}
