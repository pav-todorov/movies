//
//  HomeInteractor.swift
//  Movies
//
//  Created by Pavel on 8.07.22.
//

import Foundation
import RxSwift

// MARK: Home Interactor
struct HomeInteractor: HomeInteractive {
    // MARK: Home Interactive
    func getTopMovies(with parameters: GetTopRatedMoviesGatewayParameters) -> Observable<MovieResultEntity> {
        GetTopRatedMoviesNetworkGateway().fetch(with: parameters)
    }
    
    func getPopularMovies(with parameters: GetPopularMoviesParameters) -> Observable<MovieResultEntity> {
        GetPopularMoviesNetworkGateway().fetch(with: parameters)
    }
    
    func getNowPlayingMovies(with parameters: GetNowPlayingMoviesGatewayParameters) -> Observable<MovieResultEntity> {
        GetNowPlayingMoviesNetworkGateway().fetch(with: parameters)
    }
    
    func getUpcomingMovies(with parameters: GetUpcomingMoviesGatewayParameters) -> Observable<MovieResultEntity> {
        GetUpcomingMoviesNetworkGateway().fetch(with: parameters)
    }
    
    func getPosterImage(with parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity> {
        GetPosterImageNetworkGateway.shared.fetch(with: parameters)
    }
}
