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
        // Set up expectation
        let expectation = XCTestExpectation(description: "Add to favorites success")
        
        // Set up the mock response
        mockNetworkManager.addToFavoritesResult = .success(true)
        
        // Call the method to be tested
        viewModel.addToFavorites()
        
        // Wait for the expectation to be fulfilled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Adjust delay time as needed
            // Check if the alert is shown
            XCTAssertTrue(self.viewModel.showAlert)
            XCTAssertEqual(self.viewModel.alertTitle, "Success!")
            XCTAssertEqual(self.viewModel.alertMessage, "Added to favorites")
            
            // Fulfill expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func testAddToFavoritesFailure() {
        // Set up expectation
        let expectation = XCTestExpectation(description: "Add to favorites failure")
        
        // Set up the mock response to return a failure result
        mockNetworkManager.addToFavoritesResult = .failure(.requestFailed(NSError(domain: "MockError", code: 500, userInfo: nil)))
        
        // Call the method to be tested
        viewModel.addToFavorites()
        
        // Wait for the expectation to be fulfilled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Adjust delay time as needed
            // Check if the alert is shown
            XCTAssertTrue(self.viewModel.showAlert)
            XCTAssertEqual(self.viewModel.alertTitle, "Error!")
            
            // Fulfill expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddToFavoritesInvalidStatusCode() {
        // Set up expectation
        let expectation = XCTestExpectation(description: "Add to favorites invalid status code")
        
        // Set up the mock response to return an invalid status code error
        mockNetworkManager.addToFavoritesResult = .failure(.invalidStatusCode(401))
        
        // Call the method to be tested
        viewModel.addToFavorites()
        
        // Wait for the expectation to be fulfilled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Check if the alert is shown
            XCTAssertTrue(self.viewModel.showAlert)
            XCTAssertEqual(self.viewModel.alertTitle, "Error!")
            
            // Fulfill expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    
}
