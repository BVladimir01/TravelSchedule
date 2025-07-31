//
//  TimePeriod.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

enum TimeInterval: String, CaseIterable {
    case morning = "Утро", day = "День", evening = "Вечер", night = "Ночь"
    var timeInterval: String {
        switch self {
        case .morning:
            "6:00 - 12:00"
        case .day:
            "12:00 - 18:00"
        case .evening:
            "18:00 - 00:00"
        case .night:
            "00:00 - 6:00"
        }
    }
}
