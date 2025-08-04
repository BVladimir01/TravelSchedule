//
//  Thread.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import Foundation

struct Thread: Hashable {
    let departureTime: Date
    let arrivalTime: Date
    let hasTransfers: Bool
    let carrier: Carrier
    let origin: Station
    let destination: Station
}
