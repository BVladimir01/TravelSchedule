//
//  CitiesLoadingState.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

enum DataLoadingState: Equatable, Sendable {
    case idle, loading, success, error(DataFetchingError)
}
