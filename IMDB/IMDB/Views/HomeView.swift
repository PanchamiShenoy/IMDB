import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel(networkManager: NetworkManager.shared)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if viewModel.searchText.isEmpty {
                    LatestMoviesView(viewModel: viewModel)
                } else {
                    GridView(movies: viewModel.movies)
                }
            }
            .searchable(text: $viewModel.searchText)
            .onChange(of: viewModel.searchText) { _ in
                viewModel.searchMovie(newText: viewModel.searchText)
            }
            .onAppear() {
                viewModel.fetchPopularMovies()
            }
        }
        .accentColor(.yellow)
    }
}

// MARK: - Component
struct LatestMoviesView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        Text("Latest Movies")
            .font(.title)
            .multilineTextAlignment(.leading)
            .padding(.leading, 20)
        
        GridView(movies: viewModel.latestMovies)
            .navigationTitle("IMDB Search")
            .navigationBarItems(trailing:
                                    NavigationLink {
                FavoriteView()
                    .toolbarRole(.editor)
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundStyle(Color.yellow)
            })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
