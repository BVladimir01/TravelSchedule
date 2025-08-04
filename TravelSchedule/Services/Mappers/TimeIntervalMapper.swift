//
//  TimeIntervalMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import Foundation


struct TimeIntervalMapper {
    
    func map(_ timeInterval: TimeInterval) -> TimeIntervalUIModel {

        return TimeIntervalUIModel(start: render(timeInterval.start),
                                   end: render(timeInterval.end),
                                   description: timeInterval.description)
    }
    
    private func render(_ timePoint: RelativeTimePoint) -> String {
        let hour = timePoint.hour == 0 ? "00" : timePoint.hour.formatted()
        let minute = timePoint.minute == 0 ? "00" : timePoint.minute.formatted()
        return "\(hour):\(minute)"
    }
    
    
}
