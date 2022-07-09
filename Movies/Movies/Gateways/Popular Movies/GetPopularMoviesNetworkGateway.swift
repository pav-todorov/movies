//
//  GetPopularMoviesNetworkGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import RxSwift
import Extensions

// MARK: Get Popular Movies Network Gateway
struct GetPopularMoviesNetworkGateway {
    func fetch(
        with parameters: GetTopRatedMoviesGatewayParameters) -> Observable<MovieResultEntity>
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
