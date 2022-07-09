//
//  GetPopularMoviesGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import RxSwift

// MARK: Get Popular Movies Gateway
protocol GetPopularMoviesGateway {
    func fetch(with parameters: GetPopularMoviesParameters) -> Observable<MovieResultEntity>
}
