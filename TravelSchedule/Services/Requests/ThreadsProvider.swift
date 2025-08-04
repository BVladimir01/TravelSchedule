//
//  ThreadsProvider.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

final class ThreadsProvider {
    
    private let searchService: SearchService
    private let mapper = APIThreadMapper()
    
    private let threadsPerPage = 20
    
    init(client: APIProtocol) {
        self.searchService = SearchService(client: client)
    }
    
    func fetchTreads(from origin: Station, to destination: Station, pageNumber: Int) async throws -> [Thread] {
        let segmentsResponse = try await searchService.getSchedules(from: origin.codes.yandex_code,
                                                                    to: destination.codes.yandex_code,
                                                                    limit: threadsPerPage,
                                                                    offset: pageNumber*threadsPerPage)
        guard let segments = segmentsResponse.segments else {
            throw DataFetchingError.parsingError
        }
        return segments.compactMap { mapper.map(segment: $0) }
    }
    
}
