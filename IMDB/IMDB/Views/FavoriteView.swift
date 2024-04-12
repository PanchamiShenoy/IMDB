import SwiftUI

struct FavoriteView: View {
    // MARK: - Properties
    @StateObject var viewModel = FavoriteViewModel(networkManager: NetworkManager.shared)
    
    // MARK: - Body
    var body: some View {
        VStack {
            ToggleButton(viewModel: viewModel)
            if viewModel.isRowViewSelected {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.filteredItems(for: viewModel.searchText)) { movie in
                            MovieWideView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal, 30)
            } else {
                GridView(movies: viewModel.filteredItems(for: viewModel.searchText))
            }
        }
        .searchable(text: $viewModel.searchText)
        .onAppear {
            viewModel.fetchFavoriteMovies()
        }
        .navigationTitle(FavoriteViewStrings.navTitle)
    }
    
}

// MARK: - Component
struct ToggleButton: View {
    // MARK: - Properties
    @ObservedObject var viewModel: FavoriteViewModel
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            viewModel.isRowViewSelected.toggle()
        }) {
            HStack {
                Spacer()
                Image(systemName: viewModel.isRowViewSelected ?  FavoriteViewStrings.rectangle2x2:  FavoriteViewStrings.rectangle1x2)
                    .foregroundStyle(Color.yellow)
            }
            .padding(.trailing)
        }
        .padding()
    }
}

//// MARK: - Preview
//#Preview {
//    FavoriteView()
//}
