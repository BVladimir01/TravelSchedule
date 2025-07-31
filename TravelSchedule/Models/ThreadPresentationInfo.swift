//
//  ThreadPresentationInfo.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import Foundation

struct ThreadPresentationInfo {
    let logoURL: String?
    let departure: Date
    let arrival: Date
    let hasTransfers: Bool
    let companyName: String
    
    var departureTime: String {
        representableTime(date: departure)
    }
    
    var arrivaleTime: String {
        representableTime(date: arrival)
    }
    
    var duration: String {
        Calendar.current.dateComponents([.hour], from: departure, to: arrival).hour!.description + " часов"
    }
    
    var departureDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: departure)
    }
    
    private func representableTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: departure)
    }
    
}
