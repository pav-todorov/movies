//
//  Keys.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Foundation

// MARK: - Keys
public struct Keys {
    // MARK: Properties
    static let key = APIKey.TMDBkey
    static let baseURL: String = "https://api.themoviedb.org"
    static let baseAPIURL: String = "\(baseURL)/3/movie"
    
    // MARK: Notifications
    struct Notifications {}
    
    // MARK: Initializers
    private init() {}
}
