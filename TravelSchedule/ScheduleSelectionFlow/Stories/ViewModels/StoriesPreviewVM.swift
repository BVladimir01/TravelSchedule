//
//  StoriesPreviewVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI
import Combine


// MARK: - StoriesPreviewVM
final class StoriesPreviewVM: ObservableObject {
    
    // MARK: - Internal Properties
    
    var authorsWithNewContent: [StoryAuthor] {
        authors.filter { storiesStore.hasNewContent($0) }
    }
    
    var authorsWithoutNewContent: [StoryAuthor] {
        authors.filter { !storiesStore.hasNewContent($0) }
    }
    
    // MARK: - Private Properties - State
    
    @Published private var stories: [Story]
    @Published private var authors: [StoryAuthor]
    
    // MARK: - Private Properties
    
    private let storiesStore: StoriesStore
    private var onAuthorSelection: (StoryAuthor) -> ()
    private var cancellables = Set<AnyCancellable>()

    init(storiesStore: StoriesStore, onAuthorSelection: @escaping (StoryAuthor) -> ()) {
        self.storiesStore = storiesStore
        self.stories = storiesStore.stories
        self.authors = storiesStore.authors
        self.onAuthorSelection = onAuthorSelection
        subscribeToUpdates()
    }
    
    // MARK: - Internal Methods
    
    func authorTapped(_ author: StoryAuthor) {
        onAuthorSelection(author)
    }
    
    func previewStory(of author: StoryAuthor) -> Story? {
        stories.filter { $0.authorID == author.id }.sorted(by: { $0.id < $1.id} ).first
    }
    
    // MARK: - Private Methods
    
    private func subscribeToUpdates() {
        storiesStore.$stories
            .receive(on: DispatchQueue.main)
            .assign(to: \.stories, on: self)
            .store(in: &cancellables)
        storiesStore.$authors
            .receive(on: DispatchQueue.main)
            .assign(to: \.authors, on: self)
            .store(in: &cancellables)
    }
    
}
