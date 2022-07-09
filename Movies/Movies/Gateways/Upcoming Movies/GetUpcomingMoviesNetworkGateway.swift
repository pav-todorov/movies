//
//  GetUpcomingMoviesNetworkGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Extensions
import RxSwift

// MARK: Get Upcoming Movies Network Gateway
struct GetUpcomingMoviesNetworkGateway {
    func fetch(
        with parameters: GetNowPlayingMoviesGatewayParameters) -> Observable<MovieResultEntity>
    {
        guard let url = URL(string: "\(Keys.baseAPIURL)/upcoming\(Keys.key)&\(parameters.page ?? 1)") else {
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
