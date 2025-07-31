//
//  PageType.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

enum PageType: Hashable {
    case citySelection(locationType: LocationType)
    case stationSelection(locationType: LocationType)
    case threadSelection
    case timeSpecification
}
