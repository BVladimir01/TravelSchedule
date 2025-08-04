//
//  TimeIntervalMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import Foundation


struct TimeIntervalMapper {
    
    func map(_ timeInterval: TimeInterval) -> TimeIntervalUIModel {

        return TimeIntervalUIModel(start: mapPoint(timeInterval.start),
                                   end: mapPoint(timeInterval.end),
                                   description: timeInterval.description)
    }
    
    private func mapPoint(_ point: RelativeTimePoint) -> String {
        "\(point.hour):\(point.minute)"
    }
    
}
