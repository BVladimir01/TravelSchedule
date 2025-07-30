//
//  Destination.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

enum Destination: Hashable {
    case city(selection: Selection)
    case station(selection: Selection)
    case thread
}
