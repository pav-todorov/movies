//  
//  HomeDetailRouter.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import Foundation

// MARK: - HomeDetail Router
final class HomeDetailRouter<Navigator>: HomeDetailRoutable
    where Navigator: HomeDetailNavigable
{
    // MARK: Properties
    private unowned let navigator: Navigator

    // MARK: Initializers
    init(
        navigator: Navigator
    ) {
        self.navigator = navigator
    }

    // MARK: Routable
}
