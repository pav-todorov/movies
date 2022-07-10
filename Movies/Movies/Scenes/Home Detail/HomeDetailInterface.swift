//  
//  HomeDetailInterface.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import RxSwift
import UIKit
import Shared_Models

// MARK: - HomeDetail Viewable
protocol HomeDetailViewable: AnyObject {
    var navigationTitleObservable: PublishSubject<String> { get }
    var movieEntityObservable: PublishSubject<MovieResultEntity.Movie> { get }
    var posterImageObservable: PublishSubject<UIImage?> { get }
}

// MARK: - HomeDetail Navigable
protocol HomeDetailNavigable: AnyObject {
    
}

// MARK: - HomeDetail Presentable
protocol HomeDetailPresentable {
    func viewDidLoad()
    
    func getPosterImage(parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity>
}

// MARK: - HomeDetail Routable
protocol HomeDetailRoutable {
    
}

// MARK: - HomeDetail Interactive
protocol HomeDetailInteractive {
    func getPosterImage(with parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity>
}
