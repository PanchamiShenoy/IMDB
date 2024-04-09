import SwiftUI
import UIKit

class ImageLoader {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}

struct AsyncImageView: View {
    @State private var image: UIImage?
    private var posterPath: String?

    init(posterPath: String?) {
        self.posterPath = posterPath
        loadImage()
    }

    func loadImage() {
        guard let posterPath = posterPath,
              let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
            return
        }
        
        ImageLoader().loadImage(from: url) { loadedImage in
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        }
    }

    var body: some View {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
    }

}
