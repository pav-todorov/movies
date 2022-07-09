//
//  GetNowPlayingMoviesParameters.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Foundation

// MARK: - Get Now Playing Movies Parameters
struct GetNowPlayingMoviesGatewayParameters: Encodable {
    // MARK: Properties
    let page: Int?
}
