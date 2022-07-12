//
//  SearchMovieGetewayParameters.swift
//  Search
//
//  Created by Pavel on 10.07.22.
//

import Foundation

// MARK: - Search Movie Geteway Parameters
struct SearchMovieGetewayParameters: Encodable {
    // MARK: Properties
    let query: String
    let page: Int = 1
}
