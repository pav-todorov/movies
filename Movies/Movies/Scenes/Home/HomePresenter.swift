//
//  HomePresenter.swift
//  Movies
//
//  Created by Pavel on 8.07.22.
//

import Foundation
import RxSwift
import RxCocoa
import Shared_Models

// MARK: - Home Presenter
final class HomePresenter<View, Router, Interactor>: HomePresentable
where
View: HomeViewable,
Router: HomeRoutable,
Interactor: HomeInteractive
{
    // MARK: Properties
    private unowned let view: View
    private let router: Router
    private let interactor: Interactor
    
    var didTapSegment = PublishSubject<HomeViewController.SegmentedControl>()
    var didTapMovie = PublishSubject<MovieResultEntity.Movie>()
    
    let disposeBag = DisposeBag()
    
    // MARK: Initializers
    init(
        view: View,
        router: Router,
        interactor: Interactor
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: Presentable
    func viewDidLoad() {
        bindTaps()
        getNowPlayingMovies()
    }
    
    private func bindTaps() {
        didTapSegment
            .subscribe { [weak self] segment in
                switch segment.element {
                case .NowPlaying: self?.getNowPlayingMovies()
                case .Popular: self?.getPopularMovies()
                case .TopRated: self?.getTopMovies()
                case .Upcoming: self?.getUpcomingMovies()
                case .none: return
                }
            }
            .disposed(by: disposeBag)
        
        didTapMovie
            .subscribe { [weak self] tappedMovie in
                self?.router.toHomeDetail(with: .init(movieDetail: tappedMovie))
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: Networking
    private func getTopMovies(for page: Int = 1) {
        interactor.getTopMovies(with: .init(page: page))
            .subscribe { [weak self] topMovieEntity in
                self?.view.moviesTableItemsObservable
                    .onNext(topMovieEntity)
            } onCompleted: {
                // TODO: Add HUD? + pagination via BehaviorRelay
                print("completed")
            }
            .disposed(by: disposeBag)
    }
    
    private func getPopularMovies(for page: Int = 1) {
        // TODO: Add HUD? + pagination via BehaviorRelay
        interactor.getPopularMovies(with: .init(page: page))
            .subscribe { [weak self] popularMovieEntity in
                self?.view.moviesTableItemsObservable
                    .onNext(popularMovieEntity)
            }
            .disposed(by: disposeBag)
    }
    
    private func getNowPlayingMovies(for page: Int = 1) {
        // TODO: Add HUD? + pagination via BehaviorRelay
        interactor.getNowPlayingMovies(with: .init(page: page))
            .subscribe{ [weak self] nowPlayingMoviesEntity in
                self?.view.moviesTableItemsObservable
                    .onNext(nowPlayingMoviesEntity)
            }
            .disposed(by: disposeBag)
    }
    
    private func getUpcomingMovies(for page: Int = 1) {
        // TODO: Add HUD? + pagination via BehaviorRelay
        interactor.getUpcomingMovies(with: .init(page: page))
            .subscribe { [weak self] upcomingMoviesEntity in
                self?.view.moviesTableItemsObservable
                    .onNext(upcomingMoviesEntity)
            }
            .disposed(by: disposeBag)
    }
    
    func getPosterImage(parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity> {
        interactor.getPosterImage(with: parameters)
    }
}
