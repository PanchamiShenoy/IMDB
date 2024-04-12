import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @StateObject var viewModel = HomeViewModel(networkManager: NetworkManager.shared)
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
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
                Button(action: viewModel.fetchPopularMovies, label: {
                    ZStack {
                        Rectangle().frame(width: 130, height: 50).foregroundStyle(Color.yellow)
                            .cornerRadius(8)
                        Text(HomeViewStrings.loadButton)
                            .foregroundStyle(.black)
                            .font(.title3)
                    }
                })
                .padding(.bottom, UIScreen.main.bounds.height > 700 ? 0: 30)
        }
          
        }
        .accentColor(.yellow)
    }
}

// MARK: - Component
struct LatestMoviesView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: HomeViewModel
    
    // MARK: - Body
    var body: some View {
        Text(HomeViewStrings.latestMovies)
            .font(.title)
            .multilineTextAlignment(.leading)
            .padding(.leading, 20)
        
        GridView(movies: viewModel.latestMovies)
            .navigationTitle(HomeViewStrings.navTitle)
            .navigationBarItems(trailing:
                                    NavigationLink {
                FavoriteView()
                    .toolbarRole(.editor)
            } label: {
                Image(systemName: HomeViewStrings.heart)
                    .foregroundStyle(Color.yellow)
            })
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
