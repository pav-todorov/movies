//
//  SearchViewModel.swift
//  Search
//
//  Created by Pavel on 8.07.22.
//

import Combine
import Shared_Models

// MARK: - Search View Model
class SearchViewModel: ObservableObject {
    // MARK: Properties
    private var cancellable: AnyCancellable?
    
    @Published var searchMovieResult: [MovieResultEntity.Movie] = .init()
    
    func searchMovie(by query: String) {
        self.cancellable = SearchMovieNetworkGeteway().fetch(with: .init(query: query))
            .catch { _ in Just(MovieResultEntity()) }
            .sink(receiveValue: { [weak self] movieResult in
                self?.searchMovieResult = movieResult.results
            })
    }
}
