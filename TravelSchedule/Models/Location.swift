//
//  Location.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//


struct Location: CustomStringConvertible {
    var city: String
    var station: String
    
    var description: String {
        "\(city) (\(station))"
    }
}
