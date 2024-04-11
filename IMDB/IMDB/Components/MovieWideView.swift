//
//  MovieWideView.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//

import SwiftUI

struct MovieWideView: View {
    // MARK: - Properties
    let movie: Movie
    @Environment(\.colorScheme) var colorScheme

    
    // MARK: - Body
    var body: some View {
        NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movie: movie, networkManager: NetworkManager.shared))) {
            VStack (spacing:0){
                HStack(alignment: .center, spacing: 0) {
                    AsyncImageView(movie: movie)
                        .frame(width: ( (UIScreen.main.bounds.width/2) - 20))
                        .scaledToFit()
                        .padding(.bottom, 8)
                        .padding(.leading, 10)
                    Spacer()
                    VStack(spacing: 20) {
                        Text(movie.title)
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .multilineTextAlignment(.center)
                        RatingView(movieRating: movie.voteAverage)
                    }
                    Spacer()
                }
            }
            .cornerRadius(8)
            .padding(.vertical, 5)
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    MovieWideView(movie: Movie(id: 1, title: "movie", overview: "description", posterPath: "", voteAverage: 9.08, adult: true, releaseDate: "", backdropPath: ""))
}
