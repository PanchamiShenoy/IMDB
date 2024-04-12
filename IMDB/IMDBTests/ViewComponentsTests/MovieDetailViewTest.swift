//
//  MovieDetailViewTest.swift
//  IMDBTests
//
//  Created by Panchami Shenoy on 4/10/24.
//
import XCTest
@testable import IMDB
import SwiftUI

class MovieDetailViewTests: XCTestCase {
    var viewModel: MovieDetailViewModel!
    var mockNetworkManager: MockNetworkManager!
    var movie: Movie!
    
    // Setting up initial conditions for each test case
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        movie = Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "test", voteAverage: 9.0, adult: false, releaseDate: "2024-04-10", backdropPath: "")
        viewModel = MovieDetailViewModel(movie: movie, networkManager: mockNetworkManager)
    }
    
    // Resetting to default after each test case
    override func tearDown() {
        viewModel = nil
        movie = nil
        super.tearDown()
    }
    
    // Testing the body of the MovieDetailView
    func testFavoriteView_BodyWithRowViewSelected() {
        let favoriteView = MovieDetailView(viewModel: self.viewModel)
        
        let view = favoriteView.body
        
        XCTAssertNotNil(view)
    }
    
    // Testing if the view model is initialized correctly
    func testViewModelInitializedCorrectly() {
        let expectedTitle = "Test Movie"
        let expectedOverview = "Test Overview"
        
        XCTAssertEqual(viewModel.movie.title, expectedTitle, "ViewModel should be initialized with correct movie title")
        XCTAssertEqual(viewModel.movie.overview, expectedOverview, "ViewModel should be initialized with correct movie overview")
    }
    
    // Testing the addToFavorites function in the view model
    func testAddToFavorites() {
        let expectation = XCTestExpectation(description: "Add to favorites")
        
        mockNetworkManager.addToFavoritesResult = .success(true)
        self.viewModel.addToFavorites()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
            
            XCTAssertTrue(self.viewModel.showAlert, "Add to favorites should trigger showAlert")
            XCTAssertEqual(self.viewModel.alertTitle, "Success!", "Add to favorites should show success alert title")
            XCTAssertEqual(self.viewModel.alertMessage, "Added to favorites", "Add to favorites should show success alert message")
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    // Testing the Title view
    func testTitleView() {
        let viewModel = MovieDetailViewModel(movie: Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 9.0, adult: false, releaseDate: "2024-04-10", backdropPath: ""), networkManager: NetworkManager.shared)
        
        let titleView = Title(viewModel: viewModel)
        
        XCTAssertNotNil(titleView.body)
    }
    
    // Testing the PhotoAndDescription view
    func testPhotoAndDescriptionView() {
        let viewModel = MovieDetailViewModel(movie: Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 9.0, adult: false, releaseDate: "2024-04-10", backdropPath: ""), networkManager: NetworkManager.shared)
        
        let photoAndDescriptionView = PhotoAndDescription(viewModel: viewModel)
        
        XCTAssertNotNil(photoAndDescriptionView.body)
    }
    
    // Testing the AddToFavoriteButton action
    func testAddToFavoriteButtonAction() {
        let viewModel = MovieDetailViewModel(movie: Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 9.0, adult: false, releaseDate: "2024-04-10", backdropPath: ""), networkManager: NetworkManager.shared)
        let addToFavoriteButton = AddToFavoriteButton(viewModel: viewModel)
        XCTAssertNotNil(addToFavoriteButton.body)
    }
    
    
    // Testing the CalendarView
    func testCalendarView() {
        let releaseYear = "2024"
        let calendarView = CalendarView(releaseYear: releaseYear)
        
        XCTAssertNotNil(calendarView.body)
        
    }
    
    // Testing the IsAdultView
    func testIsAdultView() {
        let isAdult = true
        let isAdultView = IsAdultView(isAdult: isAdult)
        
        XCTAssertNotNil(isAdultView.body)
    }
    
    // Testing the DetailList view
    func testDetailList() {
        let movie = Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 9.0, adult: false, releaseDate: "2024-04-10", backdropPath: "")
        let viewModel = MovieDetailViewModel(movie: movie, networkManager: NetworkManager.shared)
        let detailListView = DetailList(viewModel: viewModel)
        
        XCTAssertNotNil(detailListView.body)
    }
    
    // Testing the RatingView
    func testRatingView() {
        let movie = Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 9.0, adult: false, releaseDate: "2024-04-10", backdropPath: "")
        let view = RatingView(movieRating: movie.voteAverage)
        XCTAssertEqual(view.movieRating, movie.voteAverage)
        XCTAssertNotNil(view.body)
    }
}
