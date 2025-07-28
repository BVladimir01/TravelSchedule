//
//  APIKeyMiddleware.swift
//  TravelSchedule
//
//  Created by Vladimir on 28.07.2025.
//

import OpenAPIRuntime
import Foundation
import HTTPTypes


struct APIKeyMiddleware: ClientMiddleware {
    
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func intercept(_ request: HTTPRequest, body: HTTPBody?, baseURL: URL, operationID: String, next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[.authorization] = apiKey
        return try await next(request, body, baseURL)
    }
    
}
