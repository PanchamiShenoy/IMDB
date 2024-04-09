//
//  GridView.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//

import SwiftUI

struct GridView: View {
    // MARK: - Properties
    let movies: [Movie]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(movies, id: \.self) { movie in
                    MovieView(movie: movie)
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    GridView(movies: [Movie(id: 1, title: "movie", overview: "description", posterPath: "", voteAverage: 9.08, adult: true, releaseDate: "", backdropPath: "")])
}
