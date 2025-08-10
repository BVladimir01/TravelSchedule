//
//  StoriesFlowView.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI

struct StoriesFlowView: View {
    
    @ObservedObject private var vm: StoriesFlowVM
    
    init(vm: StoriesFlowVM) {
        self.vm = vm
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                StoryPageView(story: vm.currentStory.content)
                ProgressBar(totalSegmentsNumber: vm.currentNumberOfDisplayedStories,
                            currentSegmentIndex: vm.currentStoryLocalIndex,
                            spacing: 6,
                            currentProgress: vm.currentProgress)
                .frame(height: 6)
                .padding(.horizontal, 12)
            }
            .gesture(
                SpatialTapGesture(count: 1)
                    .onEnded { value in
                        if value.location.x <= geometry.size.width/2 {
                            vm.previousStoryTapped()
                        } else {
                            vm.nextStoryTapped()
                        }
                    }
            )
            .gesture(DragGesture()
                .onEnded { value in
                    if value.predictedEndTranslation.width > 0 {
                        vm.didSlideToPreviousAuthor()
                    } else if value.predictedEndTranslation.width < 0 {
                        vm.didSlideToNextAuthor()
                    }
                })
        }
        .overlay(alignment: .topTrailing) {
            closeButton
                .frame(width: 30, height: 30)
                .padding(.top, 50)
                .padding(.trailing, 12)
        }
        .onAppear {
            vm.viewAppeared()
        }
    }
    
    private var closeButton: some View {
        Button {
            vm.closeView()
        } label: {
            Image(.close)
                .resizable()
                .scaledToFit()
        }
        .contentShape(.circle)
    }
    
}
