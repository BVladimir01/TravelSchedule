//
//  StoriesFlowVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI
import Combine


// MARK: - StoriesFlowVM
@MainActor
final class StoriesFlowVM: ObservableObject {
    
    // MARK: - InternalProperties
    
    var currentStory: Story {
        stories[currentStoryIndex]
    }

    var currentAuthor: StoryAuthor {
        authors[currentAuthorIndex]
    }
    
    var currentStoryLocalIndex: Int {
        stories(by: currentAuthor).firstIndex(where: { $0.id == currentStory.id }) ?? 0
    }
    
    var currentNumberOfDisplayedStories: Int {
        stories(by: currentAuthor).count
    }
    
    // MARK: - Internal Properties - State
    
    @Published var currentProgress: Double = 0
    
    // MARK: - Private Properties - State
    
    @Published private var currentStoryIndex: Int
    @Published private var currentAuthorIndex: Int
    @Published private var stories: [Story]
    @Published private var authors: [StoryAuthor]
    
    // MARK: - Private Properties
    
    private var timer: Timer.TimerPublisher
    private var cancellable: Cancellable?
    private let timerConfig = TimerConfiguration(frameRate: 60, duration: 5)
    
    private var cancellables = Set<AnyCancellable>()
    
    private var onDismiss: () -> ()
    
    private let storiesStore: StoriesStore
    
    // MARK: - Initializer
    
    init(storiesStore: StoriesStore, author: StoryAuthor, onDismiss: @escaping () -> ()) {
        self.currentStoryIndex = 0
        self.currentAuthorIndex = 0
        self.timer = Timer.publish(every: timerConfig.tickInterval, on: .main, in: .common)
        self.storiesStore = storiesStore
        self.stories = storiesStore.stories
        self.authors = storiesStore.authors
        self.onDismiss = onDismiss
        setAuthor(author)
        subscribeToUpdates()
    }
    
    // MARK: - Internal Methods

    func stories(by author: StoryAuthor) -> [Story] {
        stories.filter { $0.authorID == author.id }
    }
    
    func nextStoryTapped() {
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
        storiesStore.sort()
        onDismiss()
    }
    
    func viewAppeared() {
        resetTimer()
        startTimer()
    }
    
    // MARK: Private Methods - Intentions
    
    private func showNextStory() {
        guard storiesStore.watch(story: currentStory) else {
            closeView()
            return
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
        guard currentStoryIndex > 0 else {
            resetTimer()
            startTimer()
            return
        }
        if stories[currentStoryIndex - 1].authorID != currentAuthor.id {
            resetTimer()
            startTimer()
            return
        }
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
        assignCurrentStoryIndex()
        resetTimer()
        startTimer()
    }
    
    private func showPreviousAuthor() {
        if currentAuthorIndex == 0 {
            closeView()
            return
        }
        currentAuthorIndex -= 1
        assignCurrentStoryIndex()
        resetTimer()
        startTimer()
    }
    
    // MARK: - Private Methods - Helpers
    
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
    
    private func setAuthor(_ author: StoryAuthor) {
        currentAuthorIndex = authors.firstIndex(where: { $0.id == author.id }) ?? 0
        currentStoryIndex = (stories.firstIndex(where: { $0.authorID == author.id && !$0.watched }) ??
                             stories.firstIndex(where: { $0.authorID == author.id }) ?? 0)
    }
    
    private func assignCurrentStoryIndex() {
        currentStoryIndex = (stories.firstIndex(where: { $0.authorID == currentAuthor.id && !$0.watched }) ??
                             stories.firstIndex(where: { $0.authorID == currentAuthor.id }) ?? 0)
    }
    
    private func startTimer() {
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
        currentProgress = 0
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

// MARK: - TimerConfiguration
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
