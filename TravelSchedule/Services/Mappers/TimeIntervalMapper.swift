//
//  TimeIntervalMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import Foundation


// MARK: - TimeIntervalMapper
struct TimeIntervalMapper {
    
    // MARK: - Internal Methods
    
    func map(_ timeInterval: TimeInterval) -> TimeIntervalUIModel {

        return TimeIntervalUIModel(start: render(timeInterval.start),
                                   end: render(timeInterval.end),
                                   description: timeInterval.description)
    }
    
    // MARK: - Private Methods
    
    private func render(_ timePoint: RelativeTimePoint) -> String {
        let hour = timePoint.hour == 0 ? "00" : timePoint.hour.formatted()
        let minute = timePoint.minute == 0 ? "00" : timePoint.minute.formatted()
        return "\(hour):\(minute)"
    }
    
}
