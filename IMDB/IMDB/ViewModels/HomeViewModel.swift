//
//  HomeViewModel.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//
import Foundation

/// ViewModel responsible for managing home screen data.
class HomeViewModel: ObservableObject {
    // MARK: - Properties
    let errorHandler = ErrorHandler()
    @Published var searchText = ""
    @Published var movies: [Movie] = []
    @Published var latestMovies: [Movie] = []
    var page = 1
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Initialization
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    // MARK: - Methods
    
    /// Fetches movies matching the search query from the network.
    /// - Parameter newText: The text to search for.
    func searchMovie(newText: String) {
        networkManager.searchMovies(newText: newText) { result in
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.movies = movieResponse.results
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorHandler.handleError(error)
                }
            }
        }
    }

    func fetchPopularMovies(){
        networkManager.fetchPopularMovies(page: page, completion: { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.latestMovies.append(contentsOf: movies)
                    self.page = self.page + 1
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorHandler.handleError(error)
                }
            }
        })
    }
}
