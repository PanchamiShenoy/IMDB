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
    
    // MARK: - Initialization
    
    /// Initializes the view model with a movie.
    /// - Parameter movie: The movie to display details for.
    init(movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Methods
    
    func addToFavorites() {
        NetworkManager.shared.addToFavorites(movieId: movie.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    if success {
                        self.alertTitle = "Success!"
                        self.alertMessage = "Added to favorites"
                    } else {
                        self.alertTitle = "Failed!"
                        self.alertMessage = "Failed to add to favorites"
                    }
                case .failure(let error):
                    self.alertTitle = "Error!"
                    self.alertMessage = "Failed to add to favorites: \(error.localizedDescription)"
                }
                self.showAlert = true
            }
        }
    }

}
