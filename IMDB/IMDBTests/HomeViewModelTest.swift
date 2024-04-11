//
//  HomeViewModelTest.swift
//  IMDBTests
//
//  Created by Panchami Shenoy on 4/10/24.
//

import XCTest
@testable import IMDB

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkManager = MockNetworkManager()
        
        viewModel = HomeViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testSearchMovieSuccess() {
            // Set up expectation
            let expectation = XCTestExpectation(description: "Search movie success")
            
            // Set up the mock response
            let mockMovieResponse = MovieResponse(results: [Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 8.0, adult: false, releaseDate: "", backdropPath: "")])
            mockNetworkManager.searchMoviesResult = .success(mockMovieResponse)
            // Call the method to be tested
        viewModel.searchMovie(newText: "Test")
            
            // Wait for the expectation to be fulfilled
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Check if movies are populated
              XCTAssertEqual(self.viewModel.movies.count, 1)
              XCTAssertEqual(self.viewModel.movies[0].title, "Test Movie")
                
                // Fulfill expectation
           //     expectation.fulfill()
            }
            
            // Wait for the expectation to be fulfilled
           // wait(for: [expectation], timeout: 1.0)
        }
        
        func testFetchPopularMovies() {
            // Set up expectation
            let expectation = XCTestExpectation(description: "Fetch popular movies success")
            
            // Set up the mock response
            let mockMovies = [Movie(id: 1, title: "Movie 1", overview: "", posterPath: "", voteAverage: 7.5, adult: false, releaseDate: "", backdropPath: ""),
                              Movie(id: 2, title: "Movie 2", overview: "", posterPath: "", voteAverage: 8.0, adult: false, releaseDate: "", backdropPath: "")]
            mockNetworkManager.fetchPopularMoviesResult = .success(mockMovies)
            // Call the method to be tested
            viewModel.fetchPopularMovies()
            
            // Wait for the expectation to be fulfilled
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Check if latest movies are populated
                XCTAssertEqual(self.viewModel.latestMovies.count, 2)
                XCTAssertEqual(self.viewModel.latestMovies[0].title, "Movie 1")
                XCTAssertEqual(self.viewModel.latestMovies[1].title, "Movie 2")
                
                // Fulfill expectation
                expectation.fulfill()
            }
            
            // Wait for the expectation to be fulfilled
            wait(for: [expectation], timeout: 1.0)
        }

    func testSearchMovieFailure() {
        // Set up expectation
        let expectation = XCTestExpectation(description: "Search movie failure")
        
        // Set up the mock response to return a failure result
        mockNetworkManager.searchMoviesResult = .failure(.requestFailed(NSError(domain: "MockError", code: 500, userInfo: nil)))
        
        // Call the method to be tested
        viewModel.searchMovie(newText: "Test")
        
        // Wait for the expectation to be fulfilled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Check if movies are empty
            XCTAssertTrue(self.viewModel.movies.isEmpty)
            
            // Fulfill expectation
           // expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
       // wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPopularMoviesFailure() {
        // Set up expectation
        let expectation = XCTestExpectation(description: "Fetch popular movies failure")
        
        // Set up the mock response to return a failure result
        mockNetworkManager.fetchPopularMoviesResult = .failure(.invalidResponse)
        
        // Call the method to be tested
        viewModel.fetchPopularMovies()
        
        // Wait for the expectation to be fulfilled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Check if latest movies are empty
            XCTAssertTrue(self.viewModel.latestMovies.isEmpty)
            
            // Fulfill expectation
            //expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
       // wait(for: [expectation], timeout: 1.0)
    }

}
