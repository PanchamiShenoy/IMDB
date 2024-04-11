//
//  FavoriteViewModelTest.swift
//  IMDBTests
//
//  Created by Panchami Shenoy on 4/10/24.
//

import XCTest
@testable import IMDB

class FavoriteViewModelTests: XCTestCase {
    
    var viewModel: FavoriteViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkManager = MockNetworkManager()
        
        viewModel = FavoriteViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testFetchFavoriteMoviesFailure() {
        // Set up the mock response to return a failure result
        mockNetworkManager.fetchFavoriteMoviesResult = .failure(.invalidResponse)
        // Call the method to be tested
        viewModel.fetchFavoriteMovies()
        XCTAssertTrue(viewModel.movies.isEmpty)
    }
    
    func testFetchFavoriteMovies() {
        // Set up view model for testing `fetchFavoriteMovies` method
        let movies = [Movie(id: 1, title: "Movie 1", overview: "", posterPath: "", voteAverage: 7.5, adult: false, releaseDate: "", backdropPath: ""),
                      Movie(id: 2, title: "Movie 2", overview: "", posterPath: "", voteAverage: 8.0, adult: false, releaseDate: "", backdropPath: "")]
        
        // Set up the mock response for `fetchFavoriteMovies` method
        mockNetworkManager.fetchFavoriteMoviesResult = .success(movies)
        viewModel.movies = []
        // Call the method to be tested
        viewModel.isRowViewSelected = true
        viewModel.fetchFavoriteMovies()
        
        // Assert that isRowViewSelected is set to true after fetching favorite movies
        XCTAssertTrue(viewModel.isRowViewSelected)
        
        // Wait for the expectation to be fulfilled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Check if movies are populated
            XCTAssertEqual(self.viewModel.movies.count, 2)
            XCTAssertEqual(self.viewModel.movies[0].title, "Movie 1")
            XCTAssertEqual(self.viewModel.movies[1].title, "Movie 2")
        }
        // Apply search text
        viewModel.searchText = "Movie 1"
        
        // Trigger filtering
        let filteredMovies = viewModel.filteredItems(for: viewModel.searchText)
        
        // Verify the filtered movies array
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(filteredMovies.count, 1)
            XCTAssertEqual(filteredMovies.first?.title, "Movie 1")
        }
        viewModel.searchText = ""
        
        // Trigger filtering
        viewModel.movies = viewModel.filteredItems(for: viewModel.searchText)
        
        // Verify the filtered movies array
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            XCTAssertEqual(viewModel.movies.count, 2)
        }
    }
}

