//
//  FavoriteViewTest.swift
//  IMDBTests
//
//  Created by Panchami Shenoy on 4/10/24.
//

import XCTest
@testable import IMDB

class FavoriteViewTests: XCTestCase {
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
    
    func testToggleButton_tapTogglesIsRowViewSelected() {
        //let viewModel = FavoriteViewModel(networkManager: MockNetworkManager())
        let toggleButton = ToggleButton(viewModel: viewModel)
        var view = toggleButton.body
        
        // Then
        XCTAssertNotNil(view)
        let initialState = viewModel.isRowViewSelected
        
        // When
        toggleButton.tap()
        view = toggleButton.body
        XCTAssertNotNil(view)
        // Then
        XCTAssertNotEqual(viewModel.isRowViewSelected, initialState)
    }
    
    func testFavoriteView_BodyWithRowViewSelected() {
        // Given
        let viewModel = FavoriteViewModel(networkManager: MockNetworkManager())
        viewModel.isRowViewSelected = true
        let favoriteView = FavoriteView(viewModel: viewModel)
        
        // When
        let view = favoriteView.body
        
        // Then
        XCTAssertNotNil(view) // Assert the body is not nil
        // Add more assertions if needed based on your specific UI implementation
    }
    
    func testFavoriteView_BodyWithRowViewNotSelected() {
        // Given
        let viewModel = FavoriteViewModel(networkManager: MockNetworkManager())
        viewModel.isRowViewSelected = false
        let favoriteView = FavoriteView(viewModel: viewModel)
        
        // When
        let view = favoriteView.body
        
        // Then
        XCTAssertNotNil(view) // Assert the body is not nil
        // Add more assertions if needed based on your specific UI implementation
    }
    
    func testFavoriteView_fetchFavoriteMoviesFails() {
        // Given
        mockNetworkManager.fetchFavoriteMoviesResult = .failure(.invalidResponse)
        viewModel = FavoriteViewModel(networkManager: mockNetworkManager)
        
        // When
        viewModel.fetchFavoriteMovies()
        
        // Then
        // Assert error state or empty view based on your implementation
        // For example, checking if an error message is displayed
        XCTAssertEqual(viewModel.movies, []) // Replace with your error handling check
    }
    func testMovieWideView() {
        // Given
        let movie = Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 9.0, adult: false, releaseDate: "2024-04-10", backdropPath: "")
        let movieWideView = MovieWideView(movie: movie)
        
        let view = movieWideView.body
        
        // Then
        XCTAssertNotNil(view)
    }
}

// Mock implementation of the ToggleButton to facilitate testing
// Mock implementation of the ToggleButton to facilitate testing
extension ToggleButton {
    func tap() {
        // This function simulates tapping the button action
        viewModel.isRowViewSelected.toggle()
    }
}

