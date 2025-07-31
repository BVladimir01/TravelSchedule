//
//  Location.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//


struct Location {
    var city: String?
    var station: String?
    
    var description: String? {
        guard let city, let station else { return nil }
        return "\(city) (\(station))"
    }
    
    var isDefined: Bool {
        city != nil && station != nil
    }
}
