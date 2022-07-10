//
//  GetPopularMoviesNetworkGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import RxSwift
import Extensions
import Shared_Models

// MARK: Get Popular Movies Network Gateway
struct GetPopularMoviesNetworkGateway {
    // MARK: Gatewayable
    func fetch(
        with parameters: GetPopularMoviesParameters) -> Observable<MovieResultEntity>
    {
        guard let url = URL(string: "\(Keys.baseAPIURL)/popular\(Keys.key)&\(parameters.page ?? 1)") else {
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
