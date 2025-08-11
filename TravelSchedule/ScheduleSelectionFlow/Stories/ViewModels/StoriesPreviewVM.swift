//
//  StoriesPreviewVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI
import Combine

final class StoriesPreviewVM: ObservableObject {
    
    private let storiesStore: StoriesStore
    @Published private var stories: [Story]
    @Published private var authors: [StoryAuthor]
    private var onEvent: ((Event) -> ())?
    private var cancellables = Set<AnyCancellable>()
    
    var authorsWithNewContent: [StoryAuthor] {
        authors.filter { storiesStore.hasNewContent($0) }
    }
    
    var authorsWithoutNewContent: [StoryAuthor] {
        authors.filter { !storiesStore.hasNewContent($0) }
    }
    
    init(storiesStore: StoriesStore) {
        self.storiesStore = storiesStore
        self.stories = storiesStore.stories
        self.authors = storiesStore.authors
        subscribeToUpdates()
    }
    
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
    
    func authorTapped(_ author: StoryAuthor) {
        onEvent?(.authorTapped(author: author))
    }
    
    func setActions(_ actions: @escaping (Event) -> ()) {
        self.onEvent = actions
    }
    
    func previewStory(of author: StoryAuthor) -> Story? {
        stories.filter { $0.authorID == author.id }.sorted(by: { $0.id < $1.id} ).first
    }
    
    enum Event {
        case authorTapped(author: StoryAuthor)
    }
    
}
