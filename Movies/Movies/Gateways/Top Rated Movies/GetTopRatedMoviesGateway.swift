//
//  GetTopRatedMoviesGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import RxSwift

// MARK: - Get Top Rated Movies Gateway
protocol GetTopRatedMoviesGateway {
    func fetch(with parameters: GetTopRatedMoviesGatewayParameters) -> Observable<MovieResultEntity>
}
