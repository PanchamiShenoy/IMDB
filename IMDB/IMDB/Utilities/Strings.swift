//
//  Strings.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/12/24.
//

import Foundation

enum ErrorHandlStrings {
    static let invalidURL = String("Invalid URL")
    static let requestFailed = String("Request failed: ")
    
    static let invalidResponse = String("Invalid response from the server")
    static let InvalidStatudCode = String("Invalid status code: ")
    static let decodingError = String("Decoding error: ")
}

enum AysncImageStrings {
    static let url = String("https://image.tmdb.org/t/p/w500")
    static let postUnavailable = String("poster_not_available")
}

enum RatingViewStrings {
    static let star = String("star.fill")
}

enum FavoriteViewStrings {
    static let navTitle = String("Favorites")
    static let rectangle1x2 = String("rectangle.grid.1x2.fill")
    static let rectangle2x2 = String("rectangle.grid.2x2.fill")
}

enum MovieDetailViewStrings {
    static let url = String("https://image.tmdb.org/t/p/w500")
    static let postUnavailable = String("poster_not_available")
    static let plus = String("plus")
    static let calendar = String("calendar")
    static let addToFav = String("Add To Favorites")
}

enum HomeViewStrings {
    static let heart = String("heart.fill")
    static let navTitle = String("IMDB Search")
    static let latestMovies = String("Latest Movies")
    static let loadButton = String("Load More")
}

enum AlertViewStrings {
    static let success = String("Success!")
    static let addToFav = String("Added to favorites")
    static let error = String("Error!")
    static let failedMessage = String("Failed to add to favorites:")
}

enum NetworkManagerStrings {
    
    static let authorization = String(" Authorization")
    static let bearer = String(" Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYjc0ZTRiZmQzODQ5YTllYTkzMzM2NGMyZjU0OGYwYiIsInN1YiI6IjY2MTJjMDllMTk2OTBjMDE0OWEzMTVkNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OUzLXGiijCmQIiiHHHmayj9-eWzAswIZsdW1Dk5u0sY")
    static let getMethod = String("GET")
    static let postMethod = String("POST")
    static let contentType = String("content-type")
    static let applicationJson = String("application/json")
    static let fetchFavURL = String("https://api.themoviedb.org/3/account/21195631/favorite/movies?language=en-US&page=1&sort_by=created_at.asc&api_key=fb74e4bfd3849a9ea933364c2f548f0b")
  
    static let addFavURL = String(  "https://api.themoviedb.org/3/account/21195631/favorite")
    static let accept = String("Accept")
}
