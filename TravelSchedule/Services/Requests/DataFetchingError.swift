//
//  CitiesFetchingError.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

enum DataFetchingError: Error, Equatable {
    
    case parsingError
    case serverError(error: Error)
    case noInternetError
    
    static func == (lhs: DataFetchingError, rhs: DataFetchingError) -> Bool {
        switch (lhs, rhs) {
        case (.parsingError, .parsingError):
            return true
        case (.noInternetError, .noInternetError):
            return true
        case (.serverError(error: let lhsError), .serverError(error: let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
    
}
