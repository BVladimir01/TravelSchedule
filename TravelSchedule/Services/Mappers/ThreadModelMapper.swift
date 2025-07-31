//
//  ThreadModelMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import Foundation
struct ThreadModelMapper {
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private let departureDateFormatter: DateFormatter = {
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
    
    func map(_ thread: Thread) -> ThreadUIModel {
        return ThreadUIModel(carrierLogoURL: thread.carrier.logoURL,
                             carrierTitle: thread.carrier.title,
                             departureTime: timeFormatter.string(from: thread.departureTime),
                             arrivalTime: timeFormatter.string(from: thread.arrivalTime),
                             hasTransfers: thread.hasTransfers,
                             duration: durationFormatter.string(from: thread.departureTime, to: thread.arrivalTime) ?? "",
                             departureDate: departureDateFormatter.string(from: thread.departureTime))
    }
}
