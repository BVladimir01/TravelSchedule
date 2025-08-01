//
//  CitiesLoadingStateContainer.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

import SwiftUI

final class CitiesLoadingStateContainer: ObservableObject {
    @Published var loadingState: CitiesLoadingState = .idle
}
