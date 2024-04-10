//
//  AsyncImageView.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}

struct AsyncImageView: View {
    let movie: Movie
    
    var body: some View {
        if let posterPath = movie.posterPath,
           let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
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
                    Image("poster_not_available")
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(8)
                }
            }
        } else {
            Image("poster_not_available")
                .resizable()
                .scaledToFill()
                .cornerRadius(8)
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(movie: Movie(id: 1, title: "Movie", overview: "Description", posterPath: "", voteAverage: 9.08, adult: true, releaseDate: "", backdropPath: ""))
    }
}

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
