//  
//  HomeDetailInteractor.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Foundation
import RxSwift

// MARK: - HomeDetail Interactor
struct HomeDetailInteractor: HomeDetailInteractive {
    func getPosterImage(with parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity> {
        GetPosterImageNetworkGateway.shared.fetch(with: parameters)
    }
}
