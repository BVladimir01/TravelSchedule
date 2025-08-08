//
//  StoriesFlowVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI

final class StoriesFlowVM: ObservableObject {
    
    var currentStory: Story {
        stories[currentStoryIndex]
    }

    var currentAuthor: StoryAuthor {
        authors[currentAuthorIndex]
    }
    
    @Published private(set) var currentStoryIndex: Int
    @Published private(set) var currentAuthorIndex: Int
    @Published private(set) var isShowingStoriesFlow = false
    
    private(set) var stories: [Story]
    private(set) var authors: [StoryAuthor]
    
    private let onEvent: (Event) -> ()

    init(currentStory: Story, currentAuthor: StoryAuthor, stories: [Story], authors: [StoryAuthor], onEvent: @escaping (Event) -> Void) {
        self.currentStoryIndex = 0
        self.currentAuthorIndex = 0
        self.stories = stories
        self.authors = authors
        self.onEvent = onEvent
        sortAuthors()
        sortStories()
        currentStoryIndex = stories.firstIndex(where: { $0.id == currentStory.id }) ?? 0
        currentAuthorIndex = authors.firstIndex(where: { $0.id == currentAuthor.id }) ?? 0
    }
    
    func stories(by author: StoryAuthor) -> [Story] {
        stories.filter { $0.authorID == author.id }
    }
    
    func storyWatched(story: Story) {
        showNextStory()
    }
    
    func nextStoryTapped() {
        onEvent(.storyWatched(story: currentStory))
        showNextStory()
    }
    
    func previousStoryTapped() {
        showPreviousStory()
    }
    
    func didSlideToNextAuthor() {
        showNextAuthor()
    }
    
    func didSlideToPreviousAuthor() {
        showPreviousAuthor()
    }
    
    private func showNextStory() {
        storyWatched(story: currentStory)
        if currentStoryIndex == stories.count - 1 {
            isShowingStoriesFlow = false
        }
        if stories[currentStoryIndex].authorID != currentAuthor.id {
            showNextAuthor()
        } else {
            currentStoryIndex += 1
        }
    }
    
    private func showPreviousStory() {
        guard currentStoryIndex > 0 else { return }
        if stories[currentStoryIndex - 1].authorID != currentAuthor.id { return }
        currentStoryIndex -= 1
    }
    
    private func showNextAuthor() {
        if currentAuthorIndex == authors.count - 1 {
            isShowingStoriesFlow = false
        }
        currentAuthorIndex += 1
        if let firstNewStory = stories(by: currentAuthor).first(where: { !$0.watched }),
           let newStoryIndex = stories.firstIndex(where: { $0.id == firstNewStory.id }) {
            currentStoryIndex = newStoryIndex
        }
    }
    
    private func showPreviousAuthor() {
        if currentAuthorIndex == 0 {
            isShowingStoriesFlow = false
        }
        currentAuthorIndex -= 1
        if let firstNewStory = stories(by: currentAuthor).first(where: { !$0.watched }),
           let newStoryIndex = stories.firstIndex(where: { $0.id == firstNewStory.id }) {
            currentStoryIndex = newStoryIndex
        }
    }
    
    private func sortAuthors() {
        guard Set(authors.map { $0.id} ).count == authors.count else {
            fatalError()
        }
        authors.sort(by: { $0.id < $1.id })
    }
    
    private func sortStories() {
        stories.sort(by: { $0.id < $1.id })
        var newStories: [Story] = []
        authors.forEach { author in
            newStories.append(contentsOf: stories(by: author))
        }
        stories = newStories
    }
    
}

extension StoriesFlowVM {
    enum Event {
        case storyWatched(story: Story)
    }
}
