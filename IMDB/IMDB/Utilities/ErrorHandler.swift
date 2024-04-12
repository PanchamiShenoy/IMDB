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
            print(ErrorHandlStrings.invalidURL)
        case .requestFailed(let underlyingError):
            print("\(ErrorHandlStrings.requestFailed) \(underlyingError.localizedDescription)")
        case .invalidResponse:
            print(ErrorHandlStrings.invalidResponse)
        case .invalidStatusCode(let statusCode):
            print("\(ErrorHandlStrings.InvalidStatudCode)\(statusCode)")
        case .decodingError(let decodingError):
            print("\(ErrorHandlStrings.InvalidStatudCode) \(decodingError.localizedDescription)")
        }
    }
}
