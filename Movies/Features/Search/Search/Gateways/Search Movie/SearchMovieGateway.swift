//
//  SearchMovieGateway.swift
//  Search
//
//  Created by Pavel on 10.07.22.
//

import Combine
import Shared_Models
import UIKit

// MARK: Search Movie Gateway
protocol SearchMovieGeteway {
    func fetch(with parameters: SearchMovieGetewayParameters) -> AnyPublisher<MovieResultEntity, Error>
}
