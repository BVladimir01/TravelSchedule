//
//  TimePoint.swift
//  TravelSchedule
//
//  Created by Vladimir on 04.08.2025.
//

struct RelativeTimePoint: Hashable, Comparable, Sendable {
    
    let hour: Int
    let minute: Int
    
    static func < (lhs: RelativeTimePoint, rhs: RelativeTimePoint) -> Bool {
        if lhs.hour < rhs.hour {
            return true
        } else if lhs.hour == rhs.hour {
            return lhs.minute < rhs.minute
        } else {
            return false
        }
    }
    
}
