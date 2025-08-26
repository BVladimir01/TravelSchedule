//
//  TimePeriod.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import Foundation

struct TimeInterval: Hashable, Comparable, Sendable {
    
    let start: RelativeTimePoint
    let end: RelativeTimePoint
    let description: String
    
    static func < (lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        lhs.start < rhs.start
    }

    func contains(timePoint: RelativeTimePoint) -> Bool {
        return start <= timePoint && timePoint <= end
    }
    
}
