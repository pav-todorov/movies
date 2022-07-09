//  
//  HomeDetailViewController.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import UIKit
import RxSwift

// MARK: - HomeDetail View Controller
final class HomeDetailViewController:
    UIViewController,
    HomeDetailViewable, HomeDetailNavigable
{
    // MARK: Subviews
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemMint
        return scrollView
    }()
    
    private let contentWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        imageView.image = UIImage(systemName: "house")
        return imageView
    }()
    
    private let movieDescription: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.backgroundColor = .yellow
        textView.textColor = .blue
        return textView
    }()
    
    // MARK: Properties
    var presenter: (any HomeDetailPresentable)!
    
    private typealias UIModel = HomeDetailUIModel
    
    private let disposeBag = DisposeBag()
    var navigationTitleObservable = PublishSubject<String>()
    var movieEntityObservable = PublishSubject<MovieResultEntity.Movie>()
    var posterImageObservable = PublishSubject<UIImage?>()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter.viewDidLoad()
    }

    // MARK: Setup
    private func setUp() {
        bindViews()
        setUpView()
        addSubviews()
        setUpLayout()
        setUpNavBar()
    }
    
    private func bindViews() {
        posterImageObservable
            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: UIImage(systemName: "xmark.octagon"))
            .drive(posterView.rx.image)
            .disposed(by: disposeBag)
        
        movieEntityObservable
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] movieEntity in
                self?.movieDescription.text = movieEntity.element?.overview
            }
            .disposed(by: disposeBag)

    }
    
    private func setUpView() {
        view.backgroundColor = UIModel.Colors.background
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(posterView)
        scrollView.addSubview(movieDescription)
        
//        scrollView.addSubview(contentWrapper)
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            posterView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            posterView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            posterView.heightAnchor.constraint(equalToConstant: 250),
            posterView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            
            movieDescription.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 30),
            movieDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieDescription.heightAnchor.constraint(equalToConstant: 500),
            movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            movieDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setUpNavBar() {
        navigationTitleObservable
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }

    // MARK: Viewable

    // MARK: Navigable

}
