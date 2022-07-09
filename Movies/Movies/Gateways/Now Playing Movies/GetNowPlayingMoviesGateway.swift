//
//  GetNowPlayingMoviesGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import RxSwift

// MARK: Get Now Playing Movies Gateway
protocol GetNowPlayingMoviesGateway {
    func fetch(with parameters: GetNowPlayingMoviesGatewayParameters) -> Observable<MovieResultEntity>
}
