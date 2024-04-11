//
//  MovieDetailViewModelTest.swift
//  IMDBTests
//
//  Created by Panchami Shenoy on 4/10/24.
//

import XCTest
@testable import IMDB

class MovieDetailViewModelTests: XCTestCase {
    
    var viewModel: MovieDetailViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = MovieDetailViewModel(movie: Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 8.0, adult: false, releaseDate: "", backdropPath: ""), networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testAddToFavoritesSuccess() {
        let expectation = XCTestExpectation(description: "Add to favorites success")
        
        mockNetworkManager.addToFavoritesResult = .success(true)
        viewModel.addToFavorites()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Adjust delay time as needed
            XCTAssertTrue(self.viewModel.showAlert)
            XCTAssertEqual(self.viewModel.alertTitle, "Success!")
            XCTAssertEqual(self.viewModel.alertMessage, "Added to favorites")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func testAddToFavoritesFailure() {
        let expectation = XCTestExpectation(description: "Add to favorites failure")
        
        mockNetworkManager.addToFavoritesResult = .failure(.requestFailed(NSError(domain: "MockError", code: 500, userInfo: nil)))
        
        viewModel.addToFavorites()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Adjust delay time as needed
            XCTAssertTrue(self.viewModel.showAlert)
            XCTAssertEqual(self.viewModel.alertTitle, "Error!")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testAddToFavoritesInvalidStatusCode() {
        let expectation = XCTestExpectation(description: "Add to favorites invalid status code")
        
        mockNetworkManager.addToFavoritesResult = .failure(.invalidStatusCode(401))
        
        viewModel.addToFavorites()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.viewModel.showAlert)
            XCTAssertEqual(self.viewModel.alertTitle, "Error!")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    
}
class MockNetworkManager: NetworkManagerProtocol {
    
    func fetchFavoriteMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        if let result = fetchFavoriteMoviesResult {
            completion(result)
        }
    }
    
    func searchMovies(newText: String, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void) {
        if let result = searchMoviesResult {
            completion(result)
        }
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        if let result = fetchPopularMoviesResult {
            completion(result)
        }
    }
    
    var searchMoviesResult: Result<MovieResponse, NetworkError>?
    var fetchPopularMoviesResult: Result<[Movie], NetworkError>?
    
    var addToFavoritesResult: Result<Bool, NetworkError>?
    var fetchFavoriteMoviesResult: Result<[Movie], NetworkError>?
    
    func addToFavorites(movieId: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        if let result = addToFavoritesResult {
            completion(result)
        }
    }
}
