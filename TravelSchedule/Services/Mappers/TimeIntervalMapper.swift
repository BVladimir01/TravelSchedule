//
//  TimeIntervalMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import Foundation


struct TimeIntervalMapper {
    
    private let formatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    func map(_ timeInterval: TimeInterval) -> TimeIntervalUIModel {
        
        let startString: String?
        let endString: String?
        
        let start = DateComponents(hour: timeInterval.start.hour, minute: timeInterval.start.minutes)
        if let startDate = Calendar.current.date(from: start) {
            startString = formatter.string(from: startDate)
        } else {
            startString = nil
        }
        
        let end = DateComponents(hour: timeInterval.end.hour, minute: timeInterval.end.minutes)
        if let endDate = Calendar.current.date(from: end) {
            endString = formatter.string(from: endDate)
        } else {
            endString = nil
        }
        
        return TimeIntervalUIModel(start: startString ?? "",
                                   end: endString ?? "",
                                   description: timeInterval.description)
    }
    
}
