//
//  GetUpcomingMoviesGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import RxSwift

// MARK: Get Upcoming Movies Gateway
protocol GetUpcomingMoviesGateway {
    func fetch(with parameters: GetUpcomingMoviesGatewayParameters) -> Observable<MovieResultEntity>
}
