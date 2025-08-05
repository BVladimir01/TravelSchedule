//
//  CitiesFetchingError.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

enum DataFetchingError: Error, Equatable {
    
    case parsingError
    case serverError(description: String?)
    case noInternetError
    
    static func == (lhs: DataFetchingError, rhs: DataFetchingError) -> Bool {
        switch (lhs, rhs) {
        case (.parsingError, .parsingError):
            return true
        case (.noInternetError, .noInternetError):
            return true
        case (.serverError(description: let lhsDescription), .serverError(description: let rhsDescription)):
            return lhsDescription == rhsDescription
        default:
            return false
        }
    }
    
}
