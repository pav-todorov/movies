//
//  GetTopRatedMoviesNetworkGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import RxSwift
import Extensions
import Shared_Models

// MARK: - Get Top Rated Movies Network Gateway
struct GetTopRatedMoviesNetworkGateway: GetTopRatedMoviesGateway {
    // MARK: Gatewayable
    func fetch(
        with parameters: GetTopRatedMoviesGatewayParameters) -> Observable<MovieResultEntity>
    {
        guard let url = URL(string: "\(Keys.baseAPIURL)/top_rated\(Keys.key)&\(parameters.page ?? 1)") else {
            fatalError()
        }
        
        return URLRequest.load(resources: Resources<MovieResultEntity>(url: url))
            .observe(on: MainScheduler.instance)
            .catch { error in
                print(error)
                return Observable.just(MovieResultEntity())
            }
    }
}
