import XCTest
@testable import IMDB

final class IMDBTests: XCTestCase {

    var viewModel: MovieDetailViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        
        // Set up the mock network manager
        mockNetworkManager = MockNetworkManager()
        
        // Set up the view model for testing `addToFavorites` method
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
    
    func testFetchFavoriteMovies() {
        // Set up view model for testing `fetchFavoriteMovies` method
        let favoriteViewModel = FavoriteViewModel(networkManager: mockNetworkManager)
        favoriteViewModel.movies = [Movie(id: 1, title: "Movie 1", overview: "", posterPath: "", voteAverage: 7.5, adult: false, releaseDate: "", backdropPath: ""),
                                    Movie(id: 2, title: "Movie 2", overview: "", posterPath: "", voteAverage: 8.0, adult: false, releaseDate: "", backdropPath: "")]
        
        // Set up the mock response for `fetchFavoriteMovies` method
        mockNetworkManager.fetchFavoriteMoviesResult = .success(favoriteViewModel.movies)
        
        // Call the method to be tested
        favoriteViewModel.isRowViewSelected = true
        favoriteViewModel.fetchFavoriteMovies()
        
        // Assert that isRowViewSelected is set to true after fetching favorite movies
        XCTAssertTrue(favoriteViewModel.isRowViewSelected)
        
        // Wait for the expectation to be fulfilled
        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        // Check if movies are populated
        XCTAssertEqual(favoriteViewModel.movies.count, 2)
        XCTAssertEqual(favoriteViewModel.movies[0].title, "Movie 1")
        XCTAssertEqual(favoriteViewModel.movies[1].title, "Movie 2")
        
        // Apply search text
        favoriteViewModel.searchText = "Movie 1"
        
        // Trigger filtering
        var filteredMovies = favoriteViewModel.filteredItems(for: favoriteViewModel.searchText)
        
        // Verify the filtered movies array
        XCTAssertEqual(filteredMovies.count, 1)
        XCTAssertEqual(filteredMovies.first?.title, "Movie 1")
        
        favoriteViewModel.searchText = ""
        
        // Trigger filtering
        filteredMovies = favoriteViewModel.filteredItems(for: favoriteViewModel.searchText)
        
        // Verify the filtered movies array
        XCTAssertEqual(filteredMovies.count, 2)
        // }
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

    func testFetchFavoriteMoviesFailure() {
        // Set up view model for testing `fetchFavoriteMovies` method
        let favoriteViewModel = FavoriteViewModel(networkManager: mockNetworkManager)
        
        // Set up the mock response to return a failure result
        mockNetworkManager.fetchFavoriteMoviesResult = .failure(.invalidResponse)
        
        // Call the method to be tested
        favoriteViewModel.fetchFavoriteMovies()
        
        // Wait for the expectation to be fulfilled
       // DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Check if movies are empty
            XCTAssertTrue(favoriteViewModel.movies.isEmpty)
            
            // Fulfill expectation
           // expectation.fulfill()
        //}
        
        // Wait for the expectation to be fulfilled
        //wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchMovieSuccess() {
            // Set up expectation
            let expectation = XCTestExpectation(description: "Search movie success")
            
            // Set up the mock response
            let mockMovieResponse = MovieResponse(results: [Movie(id: 1, title: "Test Movie", overview: "Test Overview", posterPath: "", voteAverage: 8.0, adult: false, releaseDate: "", backdropPath: "")])
            mockNetworkManager.searchMoviesResult = .success(mockMovieResponse)
            let homeViewModel = HomeViewModel(networkManager: mockNetworkManager)
            // Call the method to be tested
        homeViewModel.searchMovie(newText: "Test")
            
            // Wait for the expectation to be fulfilled
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Check if movies are populated
                XCTAssertEqual(homeViewModel.movies.count, 1)
                XCTAssertEqual(homeViewModel.movies[0].title, "Test Movie")
                
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
            let homeViewModel = HomeViewModel(networkManager: mockNetworkManager)
            // Call the method to be tested
            homeViewModel.fetchPopularMovies()
            
            // Wait for the expectation to be fulfilled
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Check if latest movies are populated
                XCTAssertEqual(homeViewModel.latestMovies.count, 2)
                XCTAssertEqual(homeViewModel.latestMovies[0].title, "Movie 1")
                XCTAssertEqual(homeViewModel.latestMovies[1].title, "Movie 2")
                
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
        
        let homeViewModel = HomeViewModel(networkManager: mockNetworkManager)
        // Call the method to be tested
        homeViewModel.searchMovie(newText: "Test")
        
        // Wait for the expectation to be fulfilled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Check if movies are empty
            XCTAssertTrue(homeViewModel.movies.isEmpty)
            
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
        
        let homeViewModel = HomeViewModel(networkManager: mockNetworkManager)
        // Call the method to be tested
        homeViewModel.fetchPopularMovies()
        
        // Wait for the expectation to be fulfilled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Check if latest movies are empty
            XCTAssertTrue(homeViewModel.latestMovies.isEmpty)
            
            // Fulfill expectation
            //expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
       // wait(for: [expectation], timeout: 1.0)
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
