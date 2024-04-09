//
//  AsyncImageView.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//

import SwiftUI

struct AsyncImageView: View {
    // MARK: - Proprties
    let movie: Movie
    
    // MARK: - Body
    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
            image
                .resizable()
                .scaledToFill()
                .cornerRadius(8)
        }
    placeholder: {
        Image("poster_not_available")
    }
    }
}

// MARK: - Preview
#Preview {
    AsyncImageView(movie: Movie(id: 1, title: "movie", overview: "description", posterPath: "", voteAverage: 9.08, adult: true, releaseDate: "", backdropPath: "" ))
}
