//
//  HomeInterface.swift
//  Movies
//
//  Created by Pavel on 8.07.22.
//

import RxSwift
import RxCocoa
import FluentUI
import UIKit
import Shared_Models

// MARK: - Home Viewable
protocol HomeViewable: AnyObject {
    var moviesTableItemsObservable: PublishSubject<MovieResultEntity> { get }
}

// MARK: - Home Navigable
protocol HomeNavigable where Self: UIViewController {}

// MARK: - Home Presentable
protocol HomePresentable {
    func viewDidLoad()
    
    var didTapSegment: PublishSubject<HomeViewController.SegmentedControl> { get }
    var didTapMovie: PublishSubject<MovieResultEntity.Movie> { get }
    
    func getPosterImage(parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity>
}

// MARK: - Home Routable
protocol HomeRoutable {
    func toHomeDetail(with parameters: HomeDetailParameters)
}

// MARK: - Home Interactive
protocol HomeInteractive {
    func getTopMovies(with: GetTopRatedMoviesGatewayParameters) -> Observable<MovieResultEntity>
    func getPopularMovies(with: GetPopularMoviesParameters) -> Observable<MovieResultEntity>
    func getNowPlayingMovies(with: GetNowPlayingMoviesGatewayParameters) -> Observable<MovieResultEntity>
    func getUpcomingMovies(with: GetUpcomingMoviesGatewayParameters) -> Observable<MovieResultEntity>
    
    func getPosterImage(with parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity>
}
