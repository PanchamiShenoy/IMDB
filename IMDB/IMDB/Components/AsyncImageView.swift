//
//  AsyncImageView.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//

import SwiftUI

struct AsyncImageView: View {
    let movie: Movie
    
    var body: some View {
        if let posterPath = movie.posterPath,
           let posterURL = URL(string: "\(AysncImageStrings.url)\(posterPath)") {
            if let cachedImage = ImageCache.shared.getImage(for: posterURL) {
                
                Image(uiImage: cachedImage)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(8)
            } else {
                AsyncImage(url: posterURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(8)
                        .onAppear {
                            // Cache the image when it's loaded
                            let size = CGSize(width: (UIScreen.main.bounds.width/2 - 20), height: 300)
                               let uiImage = image.getUIImage(newSize: size)
                            ImageCache.shared.setImage(uiImage ?? UIImage(), for: posterURL)
                        }
                } placeholder: {
                    Image(AysncImageStrings.postUnavailable)
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(8)
                }
            }
        } else {
            Image(AysncImageStrings.postUnavailable)
                .resizable()
                .scaledToFill()
                .cornerRadius(8)
        }
    }
}

//struct AsyncImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncImageView(movie: Movie(id: 1, title: "Movie", overview: "Description", posterPath: "", voteAverage: 9.08, adult: true, releaseDate: "", backdropPath: ""))
//    }
//}

extension Image {
    @MainActor
    func getUIImage(newSize: CGSize) -> UIImage? {
        let image = resizable()
            .scaledToFill()
            .frame(width: newSize.width, height: newSize.height)
            .clipped()
        return ImageRenderer(content: image).uiImage
    }
}
