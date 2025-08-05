//
//  TimeIntervalUIMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import Foundation


// MARK: - TimeIntervalUIMapper
struct TimeIntervalUIMapper {
    
    // MARK: - Internal Methods
    
    func map(_ timeInterval: TimeInterval) -> TimeIntervalUIModel {

        return TimeIntervalUIModel(start: render(timeInterval.start),
                                   end: render(timeInterval.end),
                                   description: timeInterval.description)
    }
    
    // MARK: - Private Methods
    
    private func render(_ timePoint: RelativeTimePoint) -> String {
        let hour = timePoint.hour < 10 ? "0\(timePoint.hour.formatted())" : timePoint.hour.formatted()
        let minute = timePoint.minute < 10 ? "0\(timePoint.minute.formatted())" : timePoint.minute.formatted()
        return "\(hour):\(minute)"
    }
    
}
