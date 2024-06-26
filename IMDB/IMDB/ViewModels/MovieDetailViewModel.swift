//
//  MovieDetailViewModel.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//
import Foundation

/// ViewModel responsible for managing movie details.
class MovieDetailViewModel: ObservableObject {
    // MARK: - Properties
    @Published var movie: Movie
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    // MARK: - Dependencies
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Initialization
    
    /// Initializes the view model with a movie and a network manager.
    /// - Parameters:
    ///   - movie: The movie to display details for.
    ///   - networkManager: The network manager to use for API requests.
    init(movie: Movie, networkManager: NetworkManagerProtocol) {
        self.movie = movie
        self.networkManager = networkManager
    }
    
    // MARK: - Methods
    
    /// add movies to fav in the network
    func addToFavorites() {
        networkManager.addToFavorites(movieId: movie.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    if success {
                        self.alertTitle = AlertViewStrings.success
                        self.alertMessage = AlertViewStrings.addToFav
                        self.showAlert = true
                    }
                case .failure(let error):
                    self.alertTitle = AlertViewStrings.error
                    self.alertMessage = "\(AlertViewStrings.failedMessage) \(error.localizedDescription)"
                    self.showAlert = true
                }
               
            }
        }
    }
}
