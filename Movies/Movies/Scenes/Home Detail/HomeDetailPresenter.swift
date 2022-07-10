//  
//  HomeDetailPresenter.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Foundation
import RxSwift

// MARK: - HomeDetail Presenter
final class HomeDetailPresenter<View, Router, Interactor>: HomeDetailPresentable
    where
        View: HomeDetailViewable,
        Router: HomeDetailRoutable,
        Interactor: HomeDetailInteractive
{
    // MARK: Properties
    private unowned let view: View
    private let router: Router
    private let interactor: Interactor
    private let parameters: HomeDetailParameters
    
    private let disposeBag = DisposeBag()

    // MARK: Initializers
    init(
        view: View,
        router: Router,
        interactor: Interactor,
        parameters: HomeDetailParameters
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.parameters = parameters
    }

    // MARK: Presentable
    func viewDidLoad() {
        view.navigationTitleObservable
            .onNext(self.parameters.movieDetail.title)
        
        self.view.movieEntityObservable
            .onNext(parameters.movieDetail)
        
        getPosterImage(parameters: .init(posterURL: parameters.movieDetail.posterPath ?? ""))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] posterEntity in
                self?.view.posterImageObservable
                    .onNext(posterEntity.element?.image)
            }
            .disposed(by: disposeBag)

    }
    
    func getPosterImage(parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity> {
        interactor.getPosterImage(with: parameters)
    }
}
