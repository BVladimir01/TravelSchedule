//
//  ThreadsProvider.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

import Foundation


// MARK: - ThreadsProvider
final class ThreadsProvider {
    
    // MARK: - Private Properties
    
    private let searchService: SearchService
    private let mapper = APIThreadMapper()
    
    private let threadsPerPage: Int
    
    // MARK: - Initializers
    
    init(client: APIProtocol, threadsPerPage: Int = 20) {
        self.searchService = SearchService(client: client)
        self.threadsPerPage = threadsPerPage
    }
    
    // MARK: - Internal Methods
    
    func fetchTreads(from origin: Station, to destination: Station, pageNumber: Int) async throws -> [Thread] {
        do {
            let segmentsResponse = try await searchService.getSchedules(from: origin.codes.yandex_code,
                                                                        to: destination.codes.yandex_code,
                                                                        limit: threadsPerPage,
                                                                        offset: pageNumber*threadsPerPage)
            guard let segments = segmentsResponse.segments else {
                throw DataFetchingError.parsingError
            }
            return segments.compactMap { mapper.map(segment: $0) }
        }  catch let urlError as URLError {
            print(urlError)
            switch urlError.code {
            case .notConnectedToInternet :
                throw DataFetchingError.noInternetError
            case .timedOut:
                throw DataFetchingError.noInternetError
            default:
                throw DataFetchingError.serverError(description: urlError.localizedDescription)
            }
        } catch {
            print(error)
            throw DataFetchingError.serverError(description: error.localizedDescription)
        }
    }
    
}
