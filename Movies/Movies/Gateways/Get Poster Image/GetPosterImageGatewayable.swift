//
//  GetPosterImageGatewayable.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import RxSwift

// MARK: - Get Poster Image Gatewayable
protocol GetPosterImageGatewayable {
    func fetch(with parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity>
}
