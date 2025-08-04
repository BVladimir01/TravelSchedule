///
//  APIThreadMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

import Foundation

struct APIThreadMapper {
    
    typealias APIThread = Components.Schemas.SearchSegmentThread
    typealias APISegment = Components.Schemas.SearchSegment
    
    private let timeFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    private let dateTimeFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    func map(segment: APISegment) -> Thread? {
        print(segment)
        guard let departure = segment.departure,
              let arrival = segment.arrival,
              let originTitle = segment.from?.title,
              let originCode = segment.from?.code,
              let destinationTitle = segment.to?.title,
              let destinationCode = segment.to?.code,
              let thread = segment.thread,
              let carrier = thread.carrier,
              let carrierTitle = carrier.title,
              let startDate = segment.start_date
        else {
            return nil
        }
        print(departure)
        guard let departureTime = dateTimeFormatter.date(from: "\(startDate) \(departure)"),
              let arrivalTime = timeFormatter.date(from: arrival)
        else {
            return nil
        }
        let hasTransfers = segment.has_transfers ?? false
        return Thread(departureTime: departureTime,
                      arrivalTime: arrivalTime,
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
}
