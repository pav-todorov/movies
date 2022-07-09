//  
//  HomeDetailFactory.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import UIKit

// MARK: - HomeDetail Factory
struct HomeDetailFactory {
    // MARK: Initalizers
    private init() {}
    
    // MARK: Factory
    static func `default`(parameters: HomeDetailParameters) -> UIViewController {
        let viewController: HomeDetailViewController = .init()
        
        let router: HomeDetailRouter = .init(navigator: viewController)

        let interactor: HomeDetailInteractor = .init()

        let presenter: HomeDetailPresenter = .init(
            view: viewController,
            router: router,
            interactor: interactor,
            parameters: parameters
        )

        viewController.presenter = presenter
        
        return viewController
    }
}
