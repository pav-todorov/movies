//
//  GetTopRatedMoviesGatewayParameters.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Foundation

// MARK: - Get Top Rated Movies Gateway Parameters
struct GetTopRatedMoviesGatewayParameters: Encodable {
    // MARK: Properties
    let page: Int?
    
    // MARK: Coding Keys
    private enum CodingKeys: String, CodingKey {
        case page = "page"
    }
}
