//
//  MovieView.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//

import SwiftUI

struct MovieView: View {
    // MARK: - Properties
    let movie: Movie
    
    // MARK: - Body
    var body: some View {
        NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movie: movie, networkManager: NetworkManager.shared))
            .toolbarRole(.editor)) {
                VStack {
                    AsyncImageView(movie: movie)
                        .frame(width: ( (UIScreen.main.bounds.width/2) - 20))
                        .padding(.bottom, 8)
                }            .cornerRadius(8)
                    .padding(4)
            }
    }
}

// MARK: - Preview
#Preview {
    MovieView(movie: Movie(id: 1, title: "movie", overview: "description", posterPath: "", voteAverage: 9.08, adult: true, releaseDate: "", backdropPath: ""))
}
