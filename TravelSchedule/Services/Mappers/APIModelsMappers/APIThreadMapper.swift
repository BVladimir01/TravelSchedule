///
//  APIThreadMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

import Foundation


// MARK: - APIThreadMapper

struct APIThreadMapper {
    
    // MARK: - Types
    
    typealias APIThread = Components.Schemas.SearchSegmentThread
    typealias APISegment = Components.Schemas.SearchSegment
    
    // MARK: - Private Properties
    
    private let timeFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // MARK: - Internal Methods
    
    func map(segment: APISegment) -> Thread? {
        guard let departure = segment.departure,
              let arrival = segment.arrival,
              let originTitle = segment.from?.title,
              let originCode = segment.from?.code,
              let destinationTitle = segment.to?.title,
              let destinationCode = segment.to?.code,
              let thread = segment.thread,
              let carrier = thread.carrier,
              let carrierTitle = carrier.title,
              let startDate = segment.start_date,
              let duration = segment.duration
        else {
            return nil
        }
        guard let departureTime = timeFormatter.date(from: departure),
              let arrivalTime = timeFormatter.date(from: arrival),
              let departureDate = dateFormatter.date(from: startDate)
        else {
            return nil
        }
        let calendar = Calendar.current
        let departureTimeComponents = calendar.dateComponents([.hour, .minute], from: departureTime)
        let arrivalTimeComponents = calendar.dateComponents([.hour, .minute], from: arrivalTime)
        guard let departureTimePoint = timePoint(from: departureTimeComponents),
              let arrivalTimePoint = timePoint(from: arrivalTimeComponents)
        else {
            return nil
        }
        let hasTransfers = segment.has_transfers ?? false
        return Thread(departureTime: departureTimePoint,
                      arrivalTime: arrivalTimePoint,
                      departureDate: departureDate,
                      duration: duration,
                      hasTransfers: hasTransfers,
                      carrier: Carrier(title: carrierTitle,
                                       email: carrier.email,
                                       phone: carrier.phone,
                                       logoURL: carrier.logo),
                      origin: Station(title: originTitle,
                                      codes: Station.Codes(esr_code: nil,
                                                           yandex_code: originCode)),
                      destination: Station(title: destinationTitle,
                                           codes: Station.Codes(esr_code: nil,
                                                                yandex_code: destinationCode)))
    }
    
    // MARK: - Private Methods
    
    private func timePoint(from components: DateComponents) -> RelativeTimePoint? {
        guard let hour = components.hour, let minute = components.minute else { return nil }
        return RelativeTimePoint(hour: hour, minute: minute)
    }
    
}
