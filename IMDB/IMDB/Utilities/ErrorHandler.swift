//
//  ErrorHandler.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/9/24.
//

import Foundation

// NetworkError enum
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingError(Error)
}

// ErrorHandler class
class ErrorHandler {
    // Handle errors based on the NetworkError enum
    func handleError(_ error: NetworkError) {
        switch error {
        case .invalidURL:
            print("Invalid URL")
        case .requestFailed(let underlyingError):
            print("Request failed: \(underlyingError.localizedDescription)")
        case .invalidResponse:
            print("Invalid response from the server")
        case .invalidStatusCode(let statusCode):
            print("Invalid status code: \(statusCode)")
        case .decodingError(let decodingError):
            print("Decoding error: \(decodingError.localizedDescription)")
        }
    }
}
