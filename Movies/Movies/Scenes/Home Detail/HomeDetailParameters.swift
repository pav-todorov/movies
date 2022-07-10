//  
//  HomeDetailParameters.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Foundation
import Shared_Models

// MARK: - HomeDetail Parameters
struct HomeDetailParameters {
    // MARK: Properties
    let movieDetail: MovieResultEntity.Movie
    
    // MARK: Preview
    static var mock: Self { .init(movieDetail: .init()) }
}
