//
//  MovieDetailView.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/7/24.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Title(viewModel: viewModel)
                PhotoAndDescription(viewModel: viewModel)
                AddToFavoriteButton(viewModel: viewModel)
                DetailList(viewModel: viewModel)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(viewModel.alertTitle),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK")) {
                    }
                )
            }
        }
        .padding(.top, -5)
    }
}


struct Title: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    var body: some View {
        Text(viewModel.movie.title)
            .font(.title)
            .foregroundStyle(.primary)
            .padding(.bottom, 20)
            .multilineTextAlignment(.center)
    }
}

struct PhotoAndDescription: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.movie.backdropPath ?? "")")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    placeholder: {
                        Image("poster_not_available")
                    }
                    .frame(width: UIScreen.main.bounds.width > 414 ? (UIScreen.main.bounds.width  - 80): (UIScreen.main.bounds.width  - 20), height: UIScreen.main.bounds.width > 414 ? 250: 180)
            Text(viewModel.movie.overview)
                .foregroundStyle(.primary)
                .font(.footnote)
                .padding( 20)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, UIScreen.main.bounds.width > 414 ? 50: 20)
    }
}

struct AddToFavoriteButton: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    var body: some View {
        Button(action: {
            viewModel.addToFavorites()
        }, label: {
            ZStack {
                Rectangle()
                    .frame(height: 50)
                    .cornerRadius(5)
                    .foregroundColor(Color.yellow)
                HStack(spacing: 20){
                    Image(systemName: "plus")
                        .foregroundStyle(Color.black)
                        .font(.title3)
                        .padding(.leading, 20)
                    Text("Add to Favorites")
                        .foregroundColor(.black)
                        .font(.title3)
                    Spacer()
                }
                
            }
        })
        .padding(.horizontal, 35)
        
    }
}

struct CalendarView: View {
    let releaseYear: String

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: "calendar")
                .foregroundStyle(.yellow)
                .font(.title3)
            Text(releaseYear)
                .font(.title3)
        }
    }
}

struct IsAdultView: View {
    let isAdult: Bool

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.primary, lineWidth: 1)
                .frame(width: 50, height: 50)
            Text(isAdult ? "A" : "U")
                .font(.largeTitle)
                .foregroundColor(.yellow)
        }
    }
}

struct DetailList: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: MovieDetailViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 70)
                .cornerRadius(8)
                .foregroundColor(colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white)
            HStack {
                Spacer()
                RatingView(movieRating: viewModel.movie.voteAverage)
                Spacer()
                CalendarView(releaseYear: String(viewModel.movie.releaseDate.prefix(4)))
                Spacer()
                IsAdultView(isAdult: viewModel.movie.adult)
                Spacer()
            }
        }
        .onAppear() {
            print(viewModel.movie.adult)
        }
        .padding(35)
    }
}


#Preview {
    MovieDetailView(viewModel:  MovieDetailViewModel(movie: Movie(id: 1, title: "movie", overview: "description", posterPath: "", voteAverage: 9.08, adult: true, releaseDate: "", backdropPath: "")))
}
