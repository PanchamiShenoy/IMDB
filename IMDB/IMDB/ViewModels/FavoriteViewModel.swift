//
//  FavoriteViewModel.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/7/24.
//

import Foundation

/// ViewModel responsible for managing favorite movies.
class FavoriteViewModel: ObservableObject {
    // MARK: - Properties
    let errorHandler = ErrorHandler()
    @Published var searchText = ""
    @Published var isRowViewSelected = false
    @Published var movies: [Movie] = []
    
    // MARK: - Methods
    
    /// Filters movies based on the provided search text.
    /// - Parameter searchText: The text to filter movies by.
    /// - Returns: An array of filtered movies.
    func filteredItems(for searchText: String) -> [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    /// Fetch favorite movies from API
    func fetchFavoriteMovies() {
        NetworkManager.shared.fetchFavoriteMovies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                case .failure(let error):
                    self.errorHandler.handleError(error)
                }
            }
        }
    }
}
