//
//  GetTopRatedMoviesNetworkGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Foundation
import RxSwift
import Extensions

// MARK: - Get Top Rated Movies Network Gateway
struct GetTopRatedMoviesNetworkGateway: GetTopRatedMoviesGateway {
    func fetch(
        with parameters: GetTopRatedMoviesGatewayParameters) -> Observable<GetTopRatedMoviesEntity>
    {
        guard let url = URL(string: "\(Keys.baseAPIURL)/top_rated\(Keys.key)&\(parameters.page ?? 1)") else {
            fatalError()
        }
        
        return URLRequest.load(resources: Resources<GetTopRatedMoviesEntity>(url: url))
            .observe(on: MainScheduler.instance)
            .catch { error in
                print(error)
                return Observable.just(GetTopRatedMoviesEntity())
            }
    }
}
