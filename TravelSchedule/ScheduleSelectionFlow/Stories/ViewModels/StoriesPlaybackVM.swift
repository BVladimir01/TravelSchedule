//
//  StoriesPlaybackVM.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI
import Combine

final class StoriesPlaybackVM: ObservableObject {
    
    @Published private(set) var currentProgress: Double = 0
    @Published private(set) var currentIndex: Int
    
    var currentStory: Story {
        stories[currentIndex]
    }
    
    private let stories: [Story]
    private var timer: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    private let onEvent: (Event) -> ()
    
    private let timerConfig = TimerConfiguration(frameRate: 60, duration: 5)
    
    init(initialStory: Story, stories: [Story], onEvent: @escaping (Event) -> ()) {
        self.currentIndex = stories.firstIndex(where: { $0.id == initialStory.id }) ?? 0
        self.stories = stories
        self.onEvent = onEvent
        self.timer = Timer.publish(every: timerConfig.tickInterval, on: .main, in: .common)
    }
    
    func nextStoryTapped() {
        
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
    }
    
    private func incrementProgress(by value: Double) {
        if currentProgress + value >= 1 {
        }
    }
    
    private func incrementIndex() {
        onEvent(.storyWatched(story: currentStory))
        if currentIndex == stories.count - 1 {
            onEvent(.storiesFinished)
        }
        currentIndex += 1
        currentProgress = 0
    }
    
}

extension StoriesPlaybackVM {
    
    enum Event {
        case storyWatched(story: Story)
        case storiesFinished
    }
    
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
