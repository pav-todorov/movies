//
//  SearchDetailView.swift
//  Search
//
//  Created by Pavel on 9.07.22.
//

import SwiftUI
import Shared_Models

// MARK: Search Detail View
public struct SearchDetailView: View {
    // MARK: Properties
    let movieModel: MovieResultEntity.Movie
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title, order: .reverse)])
    private var favoriteMoviesSearch: FetchedResults<Movie>
    
    // MARK: Initializers
    public init(movieModel: MovieResultEntity.Movie) {
        self.movieModel = movieModel
    }
    
    public var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: "\(Keys.baseImageURL)\(movieModel.posterPath ?? "")")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 250, height: 280)
            
            Spacer()
            
            Text(movieModel.overview)
                .padding()
        }
        .navigationTitle(movieModel.title)
        .toolbar {
            Button {
                let unwrappedMovieModel = MovieResultEntity.Movie(
                    posterPath: self.movieModel.posterPath ?? "",
                    overview: self.movieModel.overview,
                    releaseDate: self.movieModel.releaseDate,
                    id: self.movieModel.id, originalTitle:
                        self.movieModel.originalTitle,
                    title: self.movieModel.title
                )
                
                !favoriteMoviesSearch.contains(where: { $0.title == movieModel.title })
                ? CoreDataManager.shared.saveMovie(movie: unwrappedMovieModel)
                : CoreDataManager.shared.deleteFavoriteMovie(movie: favoriteMoviesSearch.first(where: { $0.title == movieModel.title })!)
                
            } label: {
                favoriteMoviesSearch.contains(where: { $0.title == movieModel.title })
                ? Image(systemName: "heart.fill")
                    .tint(.red)
                : Image(systemName: "heart")
                    .tint(.red)
            }
        }
    }
}

struct SearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailView(movieModel: .init(posterPath: "", overview: "", releaseDate: "", id: 0, originalTitle: "", title: ""))
    }
}
