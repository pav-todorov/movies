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
    public static let key = APIKey.TMDBkey
    public static let baseURL: String = "https://api.themoviedb.org"
    public static let baseAPIURL: String = "\(baseURL)/3/"
    public static let baseImageURL = "https://image.tmdb.org/t/p/w500/"
    
    // MARK: Notifications
    struct Notifications {}
    
    // MARK: Initializers
    private init() {}
}
