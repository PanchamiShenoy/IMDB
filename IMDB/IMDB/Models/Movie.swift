//
//  Movie.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//

import Foundation

// MARK: - Movie Model

/// Represents a movie.
struct Movie: Hashable, Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let adult: Bool
    let releaseDate: String
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case adult
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Movie Response Model

/// Represents a response containing an array of movies.
struct MovieResponse: Decodable {
    let results: [Movie]
}
