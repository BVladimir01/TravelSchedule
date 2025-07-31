//
//  TimePeriod.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import Foundation

struct TimeInterval: Hashable, Comparable {
    
    let start: (hour: Int, minutes: Int)
    let end: (hour: Int, minutes: Int)
    let description: String
    
    static func == (lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        lhs.start == rhs.start && lhs.end == rhs.end
    }
    
    static func < (lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        if lhs.start.hour == rhs.start.hour {
            lhs.start.minutes < rhs.start.minutes
        } else {
            lhs.start.hour < rhs.start.hour
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(start.hour)
        hasher.combine(start.minutes)
        hasher.combine(end.hour)
        hasher.combine(end.minutes)
    }
    
}


enum TimeIntervals {
    static let morning = TimeInterval(start: (6, 0), end: (12, 0), description: "Утро")
    static let day = TimeInterval(start: (12, 0), end: (18, 0), description: "День")
    static let evening = TimeInterval(start: (18, 0), end: (24, 0), description: "Вечер")
    static let night = TimeInterval(start: (0, 0), end: (6, 0), description: "Ночь")
}
