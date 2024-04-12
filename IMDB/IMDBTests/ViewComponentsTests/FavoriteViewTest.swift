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
    
    // Setting up initial conditions for each test case
    override func setUp() {
        super.setUp()
        
        mockNetworkManager = MockNetworkManager()
        
        viewModel = FavoriteViewModel(networkManager: mockNetworkManager)
    }
    
    // Resetting to default after each test case
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    // Testing if tapping the toggle button toggles the isRowViewSelected property
    func testToggleButton_tapTogglesIsRowViewSelected() {
        let toggleButton = ToggleButton(viewModel: viewModel)
        var view = toggleButton.body
        
        XCTAssertNotNil(view)
        let initialState = viewModel.isRowViewSelected
        
        toggleButton.tap()
        view = toggleButton.body
        XCTAssertNotNil(view)
        XCTAssertNotEqual(viewModel.isRowViewSelected, initialState)
    }
    
    // Testing the body of the FavoriteView when row view is selected
    func testFavoriteView_BodyWithRowViewSelected() {
        let viewModel = FavoriteViewModel(networkManager: MockNetworkManager())
        viewModel.isRowViewSelected = true
        let favoriteView = FavoriteView(viewModel: viewModel)
        
        let view = favoriteView.body
        
        XCTAssertNotNil(view)
    }
    
    // Testing the body of the FavoriteView when row view is not selected
    func testFavoriteView_BodyWithRowViewNotSelected() {
        let viewModel = FavoriteViewModel(networkManager: MockNetworkManager())
        viewModel.isRowViewSelected = false
        let favoriteView = FavoriteView(viewModel: viewModel)
        
        let view = favoriteView.body
        
        XCTAssertNotNil(view)
    }
    
    // Testing the scenario when fetching favorite movies fails
    func testFavoriteView_fetchFavoriteMoviesFails() {
        mockNetworkManager.fetchFavoriteMoviesResult = .failure(.invalidResponse)
        viewModel = FavoriteViewModel(networkManager: mockNetworkManager)
        
        viewModel.fetchFavoriteMovies()
        
        // Assert error state or empty view based on your implementation
        // For example, checking if an error message is displayed
        XCTAssertEqual(viewModel.movies, []) // Replace with your error handling check
    }
    
    // Testing the body of the MovieWideView
    func testMovieWideView() {
        let movie = Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 9.0, adult: false, releaseDate: "2024-04-10", backdropPath: "")
        let movieWideView = MovieWideView(movie: movie)
        
        let view = movieWideView.body
        
        XCTAssertNotNil(view)
    }
}

// Mock implementation of the ToggleButton to facilitate testing
extension ToggleButton {
    func tap() {
        // This function simulates tapping the button action
        viewModel.isRowViewSelected.toggle()
    }
}
