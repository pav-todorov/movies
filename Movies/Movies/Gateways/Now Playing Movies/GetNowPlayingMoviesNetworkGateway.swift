//
//  GetNowPlayingMoviesNetworkGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Extensions
import RxSwift

// MARK: Get Now Playing Movies Network Gateway
struct GetNowPlayingMoviesNetworkGateway {
    // MARK: Gatewayable
    func fetch(
        with parameters: GetNowPlayingMoviesGatewayParameters) -> Observable<MovieResultEntity>
    {
        guard let url = URL(string: "\(Keys.baseAPIURL)/now_playing\(Keys.key)&\(parameters.page ?? 1)") else {
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
