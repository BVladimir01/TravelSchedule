//
//  Thread.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import Foundation

struct Thread: Hashable, Sendable {
    let departureTime: RelativeTimePoint
    let arrivalTime: RelativeTimePoint
    let departureDate: Date
    let duration: Int
    let hasTransfers: Bool
    let carrier: Carrier
    let origin: Station
    let destination: Station
}
