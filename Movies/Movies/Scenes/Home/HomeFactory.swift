//
//  HomeFactory.swift
//  Movies
//
//  Created by Pavel on 8.07.22.
//

import UIKit

struct HomeFactory {
    // MARK: Initalizers
    private init() {}
    
    // MARK: Factory
    static func `default`() -> UIViewController {
        let viewController: HomeViewController = .init()
        
        let router: HomeRouter = .init(navigator: viewController)

        let interactor: HomeInteractor = .init()

        let presenter: HomePresenter = .init(
            view: viewController,
            router: router,
            interactor: interactor
        )
        
        viewController.presenter = presenter
        
        return viewController
    }
}
