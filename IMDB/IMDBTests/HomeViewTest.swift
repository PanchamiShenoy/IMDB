//
//  HomeViewTest.swift
//  IMDBTests
//
//  Created by Panchami Shenoy on 4/10/24.
//

import XCTest
@testable import IMDB

class HomeViewTests: XCTestCase {
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
    
    func testSearchMovie_whenSearchTextChanges() {
        let searchText = "test"
        let expectedMovieResponse = MovieResponse(results: [Movie(id: 1, title: "movie", overview: "description", posterPath: "", voteAverage: 9.08, adult: true, releaseDate: "", backdropPath: "")])
        mockNetworkManager.searchMoviesResult = .success(expectedMovieResponse)
        
        let expectation = XCTestExpectation(description: "Search movie completion")
        
        viewModel.searchText = "test"
        viewModel.searchMovie(newText: viewModel.searchText)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.searchText, searchText, "Search text should be updated")
            XCTAssertEqual(self.viewModel.movies, expectedMovieResponse.results, "Movies should be updated with received movies")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchPopularMovies_onAppear() {
        let expectation = XCTestExpectation(description: "Search movie completion")
        
        let expectedMovies = [Movie(id: 1, title: "movie", overview: "description", posterPath: "", voteAverage: 9.08, adult: true, releaseDate: "", backdropPath: "")]
        mockNetworkManager.fetchPopularMoviesResult = .success(expectedMovies)
        viewModel.latestMovies = []
        
        viewModel.fetchPopularMovies()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.latestMovies, expectedMovies, "Latest movies should be updated with received latest movies")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
}
