//
//  StoriesFlowView.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import SwiftUI


// MARK: - StoriesFlowView
struct StoriesFlowView: View {
    
    // MARK: - Private Properties
    
    @ObservedObject private var vm: StoriesFlowVM
    
    // MARK: - Initializer
    
    init(viewModel: StoriesFlowVM) {
        self.vm = viewModel
    }
    
    // MARK: - Views
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.ypBlackUniversal.ignoresSafeArea()
                StoryPageView(story: vm.currentStory.content)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                ProgressBarView(totalSegmentsNumber: vm.currentNumberOfDisplayedStories,
                            currentSegmentIndex: vm.currentStoryLocalIndex,
                            spacing: 6,
                            currentProgress: vm.currentProgress)
                .frame(height: 6)
                .padding(.horizontal, 12)
                .padding(.top, 28)
            }
            .gesture(gesture(in: geometry))
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
    
    // MARK: - Gesture
    
    private func gesture(in geometry: GeometryProxy) -> some Gesture {
        SpatialTapGesture(count: 1)
            .onEnded { value in
                if value.location.x <= geometry.size.width/2 {
                    vm.previousStoryTapped()
                } else {
                    vm.nextStoryTapped()
                }
            }
            .simultaneously(with: DragGesture()
                .onEnded { value in
                    guard abs(value.predictedEndTranslation.width) > abs(value.predictedEndTranslation.height) else {
                        if value.predictedEndTranslation.height > 60 {
                            vm.closeView()
                        }
                        return
                    }
                    if value.predictedEndTranslation.width > 60 {
                        vm.didSlideToPreviousAuthor()
                    } else if value.predictedEndTranslation.width < -60 {
                        vm.didSlideToNextAuthor()
                    }
                })
    }
    
}
