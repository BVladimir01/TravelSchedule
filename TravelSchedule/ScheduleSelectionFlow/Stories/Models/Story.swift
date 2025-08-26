//
//  Story.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import Foundation

struct Story: Identifiable, Sendable {
    let id: UUID
    let authorID: UUID
    let content: StoryPageContent
    let watched: Bool
}
