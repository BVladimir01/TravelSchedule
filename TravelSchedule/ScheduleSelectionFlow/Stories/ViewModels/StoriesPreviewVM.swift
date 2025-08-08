//
//  StoriesPreviewVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI


final class StoriesPreviewVM: ObservableObject {
    
    private let stories: [Story]
    private let authors: [StoryAuthor]
    private let onEvent: (Event) -> ()
    
    var authorsWithNewContent: [StoryAuthor] {
        let ids = Set<StoryAuthor.ID>(stories.filter { !$0.watched }.map { $0.authorID })
        return authors.filter { ids.contains( $0.id ) }
    }
    
    var authorsWithoutNewContent: [StoryAuthor] {
        let ids = Set<StoryAuthor.ID>(stories.filter { !$0.watched }.map { $0.authorID })
        return authors.filter { !ids.contains( $0.id ) }
    }
    
    init(stories: [Story], authors: [StoryAuthor], onEvent: @escaping (Event) -> Void) {
        self.stories = stories
        self.authors = authors.sorted(by: { $0.id < $1.id })
        self.onEvent = onEvent
    }
    
    func authorTapped(_ author: StoryAuthor) {
        onEvent(.authorTapped(author: author))
    }
    
    func previewStory(of author: StoryAuthor) -> Story? {
        stories.filter { $0.authorID == author.id }.sorted(by: { $0.id < $1.id} ).first
    }
    
    enum Event {
        case authorTapped(author: StoryAuthor)
    }
    
    
}
