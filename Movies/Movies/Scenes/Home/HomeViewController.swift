//
//  HomeViewController.swift
//  Movies
//
//  Created by Pavel Todorov on 8.07.22.
//

import UIKit

// MARK: - Home View Controller
final class HomeViewController:
    UIViewController,
    HomeViewable, HomeNavigable
{
    // MARK: Subviews
    

    // MARK: Properties
    var presenter: (any HomePresentable)!
    
    private typealias UIModel = HomeModel

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
        setUpNavBar()
    }
    
    private func setUpView() {
        view.backgroundColor = UIModel.Colors.background
    }

    private func addSubviews() {

    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }
    
    private func setUpNavBar() {
        navigationItem.title = "Home"
    }

    // MARK: Viewable

    // MARK: Navigable

}
