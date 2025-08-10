//
//  StoriesFlowVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI
import Combine

final class StoriesFlowVM: ObservableObject {
    
    var currentStory: Story {
        stories[currentStoryIndex]
    }

    var currentAuthor: StoryAuthor {
        authors[currentAuthorIndex]
    }
    
    var numberOfDisplayedStories: Int {
        stories.filter { $0.authorID == currentAuthor.id }.count
    }
    
    var currentStoryLocalIndex: Int {
        stories(by: currentAuthor).firstIndex(where: { $0.id == currentStory.id }) ?? 0
    }
    
    var currentNumberOfDisplayedStories: Int {
        stories(by: currentAuthor).count
    }
    
    @Published var currentProgress: Double = 0
    
    @Published private var currentStoryIndex: Int
    @Published private var currentAuthorIndex: Int
    
    private var timer: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    private let timerConfig = TimerConfiguration(frameRate: 60, duration: 5)
    
    private var stories: [Story]
    private var authors: [StoryAuthor]
    
    private var onEvent: ((Event) -> ())?
    
    private let storiesProvider: StoriesProvider
    
    init(storiesProvider: StoriesProvider) {
        stories = storiesProvider.fetchStories()
        let authorIDs = Array(Set<StoryAuthor.ID>(stories.map { $0.authorID }))
        authors = authorIDs.compactMap { storiesProvider.author(with: $0)}
        self.currentStoryIndex = 0
        self.currentAuthorIndex = 0
        self.timer = Timer.publish(every: timerConfig.tickInterval, on: .main, in: .common)
        self.storiesProvider = storiesProvider
        sortAuthors()
        sortStories()
    }
    
    func setAuthor(_ author: StoryAuthor) {
        currentAuthorIndex = authors.firstIndex(where: { $0.id == author.id }) ?? 0
        currentStoryIndex = stories.firstIndex(where: { $0.authorID == author.id && !$0.watched }) ?? 0
    }
    
    func setActions(_ actions: @escaping (Event) -> ()) {
        self.onEvent = actions
    }
    
    func stories(by author: StoryAuthor) -> [Story] {
        stories.filter { $0.authorID == author.id }
    }
    
    func storyWatched(story: Story) {
        showNextStory()
    }
    
    func nextStoryTapped() {
        onEvent?(.storyWatched(story: currentStory))
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
    
    func closeView() {
        stopTimer()
        onEvent?(.dismiss)
    }
    
    func viewAppeared() {
        resetTimer()
        startTimer()
    }
    
    private func showNextStory() {
        print(currentStoryIndex)
        if storiesProvider.watch(story: currentStory) {
            if let index = stories.firstIndex(where: { $0.id == currentStory.id }) {
                stories[index] = Story(id: currentStory.id,
                                       authorID: currentStory.authorID,
                                       content: currentStory.content,
                                       watched: true)
            }
        }
        if currentStoryIndex == stories.count - 1 {
            closeView()
            return
        }
        else if stories[currentStoryIndex + 1].authorID != currentAuthor.id {
            showNextAuthor()
        } else {
            currentStoryIndex += 1
            resetTimer()
            startTimer()
        }
    }
    
    private func showPreviousStory() {
        guard currentStoryIndex > 0 else { return }
        if stories[currentStoryIndex - 1].authorID != currentAuthor.id { return }
        currentStoryIndex -= 1
        resetTimer()
        startTimer()
    }
    
    private func showNextAuthor() {
        if currentAuthorIndex == authors.count - 1 {
            closeView()
            return
        }
        currentAuthorIndex += 1
        if let firstNewStory = stories(by: currentAuthor).first(where: { !$0.watched }),
           let newStoryIndex = stories.firstIndex(where: { $0.id == firstNewStory.id }) {
            currentStoryIndex = newStoryIndex
        }
        resetTimer()
        startTimer()
    }
    
    private func showPreviousAuthor() {
        if currentAuthorIndex == 0 {
            closeView()
            return
        }
        currentAuthorIndex -= 1
        if let firstNewStory = stories(by: currentAuthor).first(where: { !$0.watched }),
           let newStoryIndex = stories.firstIndex(where: { $0.id == firstNewStory.id }) {
            currentStoryIndex = newStoryIndex
        }
        resetTimer()
        startTimer()
    }
    
    private func sortAuthors() {
        guard Set(authors.map { $0.id} ).count == authors.count else {
            fatalError()
        }
        authors.sort(by: { $0.id < $1.id })
        let newAuthors = authors.filter { author($0, hasNewContent: true) }
        let watchedAuthors = authors.filter { author($0, hasNewContent: false) }
        authors = newAuthors + watchedAuthors
    }
    
    private func sortStories() {
        stories.sort(by: { $0.id < $1.id })
        var newStories: [Story] = []
        authors.forEach { author in
            newStories.append(contentsOf: stories(by: author))
        }
        stories = newStories
    }
    
    private func startTimer() {
        currentProgress = 0
        cancellable = timer
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.incrementProgress(by: self.timerConfig.progressStep)
            }
    }
    
    private func stopTimer() {
        cancellable?.cancel()
    }
    
    private func resetTimer() {
        timer = Timer.publish(every: timerConfig.tickInterval, on: .main, in: .common)
    }
    
    private func incrementProgress(by value: Double) {
        if currentProgress + value >= 1 {
            showNextStory()
        }
        currentProgress += value
    }
    
    private func author(_ author: StoryAuthor, hasNewContent: Bool) -> Bool {
        stories.filter { $0.authorID == author.id}.contains(where: { !$0.watched }) == hasNewContent
    }
    
}

extension StoriesFlowVM {
    enum Event {
        case storyWatched(story: Story)
        case dismiss
    }
}

extension StoriesFlowVM {
    
    struct TimerConfiguration {
        
        private let frameRate: Double
        private let duration: Double
        
        var progressStep: Double {
            1/(frameRate*duration)
        }
        
        var tickInterval: Double {
            1/frameRate
        }
        
        init(frameRate: Double, duration: Double) {
            self.frameRate = frameRate
            self.duration = duration
        }
        
    }
    
}
