//
//  GetUpcomingMoviesNetworkGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Extensions
import RxSwift
import Shared_Models

// MARK: Get Upcoming Movies Network Gateway
struct GetUpcomingMoviesNetworkGateway {
    // MARK: Gatewayable
    func fetch(
        with parameters: GetUpcomingMoviesGatewayParameters) -> Observable<MovieResultEntity>
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
