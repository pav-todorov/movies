//
//  HomePresenter.swift
//  Movies
//
//  Created by Pavel on 8.07.22.
//

import Foundation

// MARK: - Home Presenter
final class HomePresenter<View, Router, Interactor>: HomePresentable
    where
        View: HomeViewable,
        Router: HomeRoutable,
        Interactor: HomeInteractive
{
    // MARK: Properties
    private unowned let view: View
    private let router: Router
    private let interactor: Interactor
    
    // MARK: Initializers
    init(
        view: View,
        router: Router,
        interactor: Interactor
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    // MARK: Presentable
}
