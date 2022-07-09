//
//  HomeRouter.swift
//  Movies
//
//  Created by Pavel on 8.07.22.
//

import Foundation

// MARK: - Home Router
final class HomeRouter<Navigator>: HomeRoutable
    where Navigator: HomeNavigable
{
    // MARK: Properties
    private unowned let navigator: Navigator
    
    // MARK: Initializers
    init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    // MARK: Navigable
    func toHomeDetail(with parameters: HomeDetailParameters) {
        navigator.present(HomeDetailFactory.default(parameters: parameters), animated: true)
    }
}
