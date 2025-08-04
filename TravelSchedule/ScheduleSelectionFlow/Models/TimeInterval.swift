//
//  TimePeriod.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import Foundation

struct TimeInterval: Hashable, Comparable {
    
    let start: RelativeTimePoint
    let end: RelativeTimePoint
    let description: String
    
    static func < (lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        if lhs.start.hour == rhs.start.hour {
            lhs.start.minute < rhs.start.minute
        } else {
            lhs.start.hour < rhs.start.hour
        }
    }
}


enum TimeIntervals {
    static let morning = TimeInterval(start: RelativeTimePoint(hour: 6, minute: 0), end: RelativeTimePoint(hour: 12, minute: 0), description: "Утро")
    static let day = TimeInterval(start: RelativeTimePoint(hour: 12, minute: 0), end: RelativeTimePoint(hour: 18, minute: 0), description: "День")
    static let evening = TimeInterval(start: RelativeTimePoint(hour: 18, minute: 0), end: RelativeTimePoint(hour: 24, minute: 0), description: "Вечер")
    static let night = TimeInterval(start: RelativeTimePoint(hour: 0, minute: 0), end: RelativeTimePoint(hour: 6, minute: 0), description: "Ночь")
}
