//
//  ViewModel.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


// MARK: - ScheduleNavigationViewModel
@MainActor
final class ScheduleNavigationViewModel: ObservableObject {
    
    // MARK: - Internal Properties
    
    private(set) var threadSelectionVM: ThreadsViewModel?
    private(set) var storiesFlowVM: StoriesFlowVM?
    private(set) lazy var storiesPreviewVM: StoriesPreviewVM = {
        StoriesPreviewVM(storiesStore: .shared, onAuthorSelection: { [weak self] author in
            self?.storyTapped(with: author)
        })
    }()
    
    // MARK: - Internal Properties - State
    
    @Published private(set) var loadingState: DataLoadingState = .idle
    
    @Published var originCity: City?
    @Published var originStation: Station?
    @Published var destinationCity: City?
    @Published var destinationStation: Station?
    
    @Published var path: [PageType] = []
    
    @Published var isShowingStories = false
    
    // MARK: - Internal Properties - Computed
    
    var cities: [City] {
        citiesAndStations.keys.sorted(by: { $0.title < $1.title })
    }
    
    var searchIsEnabled: Bool {
        return (originCity != nil &&
                originStation != nil &&
                destinationCity != nil &&
                destinationStation != nil
                )
    }
    
    // MARK: - Private Properties
    
    private var citiesAndStations: [City: [Station]] = [:]
    private let client: APIProtocol
    private let stationsAndCitiesProvider: StationsAndCitiesProvider
    private var selectedAuthor: StoryAuthor?
    
    // MARK: - Initializers
    
    init(client: APIProtocol) {
        self.client = client
        stationsAndCitiesProvider = StationsAndCitiesProvider(client: client)
        Task {
            await fetchCitiesAndStations()
        }
    }
    
    // MARK: Internal Methods
    
    func stations(of city: City) -> [Station] {
        citiesAndStations[city] ?? []
    }
    
    func city(of locationType: LocationType) -> City? {
        switch locationType {
        case .origin:
            return originCity
        case .destination:
            return destinationCity
        }
    }
    
    func showCitySelectionView(for locationType: LocationType) {
        path.append(.citySelection(locationType: locationType))
    }
    
    func selectCity(_ city: City, for locationType: LocationType) {
        switch locationType {
        case .origin:
            originCity = city
        case .destination:
            destinationCity = city
        }
        path.append(.stationSelection(locationType: locationType))
    }
    
    func selectStation(_ station: Station, for locationType: LocationType) {
        switch locationType {
        case .origin:
            originStation = station
        case .destination:
            destinationStation = station
        }
        // this is a walkaround
        // popping all views causes ui to freeze
        // don't know other solutions
        Task {
            _ = path.popLast()
            try await Task.sleep(nanoseconds: 5_000_000)
            _ = path.popLast()
        }
    }
    
    func swapLocationTypes() {
        let tempCity = originCity
        let tempStation = originStation
        originCity = destinationCity
        destinationCity = tempCity
        originStation = destinationStation
        destinationStation = tempStation
    }
    
    func showThreadsSelectionView() {
        guard let origin = originStation,
              let destination = destinationStation else { return }
        threadSelectionVM = ThreadsViewModel(origin: origin, destination: destination, client: client)
        path.append(.threadSelection)
    }
    
    // MARK: - Private Methods
    
    private func fetchCitiesAndStations() async {
        guard cities.isEmpty else { return }
        loadingState = .loading
        do {
            citiesAndStations = try await stationsAndCitiesProvider.fetchCitiesAndStations()
            loadingState = .success
        } catch let error as DataFetchingError {
            loadingState = .error(error)
        } catch {
            loadingState = .error(.serverError(description: error.localizedDescription))
        }
    }
    
    func storyTapped(with author: StoryAuthor) {
        storiesFlowVM = StoriesFlowVM(storiesStore: .shared, author: author, onDismiss: { [weak self] in
            self?.isShowingStories = false
        })
        isShowingStories = true
    }

}
