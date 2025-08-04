//
//  ThreadsProvider.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

import Foundation


final class ThreadsProvider {
    
    private let searchService: SearchService
    private let mapper = APIThreadMapper()
    
    private let threadsPerPage = 20
    
    init(client: APIProtocol) {
        self.searchService = SearchService(client: client)
    }
    
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
                throw DataFetchingError.serverError(error: urlError)
            }
        } catch {
            print(error)
            throw DataFetchingError.serverError(error: error)
        }
    }
    
}
