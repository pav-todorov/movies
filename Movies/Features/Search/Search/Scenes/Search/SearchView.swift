//
//  SearchView.swift
//  Search
//
//  Created by Pavel on 8.07.22.
//

import SwiftUI
import Combine
import Shared_Models

// MARK: - Search View
public struct SearchView: View {
    // MARK: Properties
    private typealias LocStrings = LocalizedStrings.Modules.Search
    
    @ObservedObject private var searchViewModel = SearchViewModel()
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title, order: .reverse)])
    private var favoriteMoviesSearch: FetchedResults<Movie>
    
    @State private var searchWord = ""

    private var movieSearch: Binding<String> {
        Binding {
            searchWord
        } set: { searchValue in
            searchWord = searchValue
            searchViewModel.searchMovie(by: searchValue)
        }
    }
    
    // MARK: Public Initializer
    public init() {}
    
    // MARK: Body
    public var body: some View {
        NavigationView {
            List {
                ForEach(searchViewModel.searchMovieResult, id: \.title){ movieModel in
                    NavigationLink(destination:
                                    SearchDetailView(movieModel: movieModel)
                        .environment(
                            \.managedObjectContext,
                             CoreDataManager.shared.persistentContainer.viewContext)
                    ) {
                        HStack {
                            AsyncImage(url: URL(string: "\(Keys.baseImageURL)\(movieModel.posterPath ?? "")")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 80)

                            Text(movieModel.title)
                            
                            Spacer()
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .opacity(favoriteMoviesSearch.contains(where: { $0.title == movieModel.title }) ? 1 : 0)
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            CoreDataManager.shared.saveMovie(movie: movieModel)
                        } label: {
                            Image(systemName: "star.fill")
                        }
                        .tint(.yellow)
                        .disabled(favoriteMoviesSearch.contains(where: { $0.title == movieModel.title }))
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {

                            let favoriteMovie = favoriteMoviesSearch.first(where: { $0.title == movieModel.title })

                            CoreDataManager.shared.deleteFavoriteMovie(movie: favoriteMovie!)

                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                        .disabled(!favoriteMoviesSearch.contains(where: { $0.title == movieModel.title }))
                    }
                } //: ForEach
            } //: List
            .navigationTitle(Text(LocStrings.modules_search_navigation_title, bundle: Bundle(identifier: "com.movies.Search")))
        }//: NavView
        .searchable(text: movieSearch, prompt: Text(LocStrings.modules_search_search_bar_prompt, bundle: Bundle(identifier: "com.movies.Search")))
    }
}

// MARK: Search View Previews
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
