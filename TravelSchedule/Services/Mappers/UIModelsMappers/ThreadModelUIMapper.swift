//
//  ThreadModelUIMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import Foundation


// MARK: - ThreadModelUIMapper
struct ThreadModelUIMapper {
    
    // MARK: - Private Properties
    
    private let departureDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        return formatter
    }()
   
    private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour]
        formatter.unitsStyle = .full
        return formatter
    }()
    
    // MARK: - Internal Methods
    
    func map(_ thread: Thread) -> ThreadUIModel {
        let departureTime = render(thread.departureTime)
        let arrivalTime = render(thread.arrivalTime)
        let departureDateString = departureDayFormatter.string(from: thread.departureDate)
        var durationComponents = DateComponents()
        durationComponents.second = thread.duration
        let duration = durationFormatter.string(from: durationComponents) ?? ""
        return ThreadUIModel(carrierLogoURL: thread.carrier.logoURL,
                             carrierTitle: thread.carrier.title,
                             departureTime: departureTime,
                             arrivalTime: arrivalTime,
                             hasTransfers: thread.hasTransfers,
                             duration: duration,
                             departureDay: departureDateString)
    }
    
    // MARK: - Private Methods
    
    private func render(_ timePoint: RelativeTimePoint) -> String {
        let hour = timePoint.hour == 0 ? "00" : timePoint.hour.formatted()
        let minute = timePoint.minute == 0 ? "00" : timePoint.minute.formatted()
        return "\(hour):\(minute)"
    }
    
}
