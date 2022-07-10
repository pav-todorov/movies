//  
//  HomeDetailViewController.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import UIKit
import RxSwift
import Shared_Models

// MARK: - HomeDetail View Controller
final class HomeDetailViewController:
    UIViewController,
    HomeDetailViewable, HomeDetailNavigable
{
    // MARK: Subviews
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "house")
        return imageView
    }()
    
    private let movieDescription: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = UIModel.Fonts.movieDescriptionTextView
        return textView
    }()
    
    // MARK: Properties
    var presenter: (any HomeDetailPresentable)!
    
    private typealias UIModel = HomeDetailUIModel
    
    private let disposeBag = DisposeBag()
    var navigationTitleObservable = PublishSubject<String>()
    var movieEntityObservable = PublishSubject<MovieResultEntity.Movie>()
    var posterImageObservable = BehaviorSubject<UIImage?>(value: nil)

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
            .compactMap({ $0 })
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
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            posterView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            posterView.leftAnchor.constraint(equalTo: view.leftAnchor),
            posterView.heightAnchor.constraint(equalToConstant: UIModel.Layout.posterViewHeight),
            posterView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            movieDescription.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: UIModel.Layout.movieDescriptionMarginVer),
            movieDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIModel.Layout.movieDescriptionMarginHor),
            movieDescription.heightAnchor.constraint(equalToConstant: UIModel.Layout.movieDescriptionHeight),
            movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIModel.Layout.movieDescriptionMarginHor),
            movieDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -UIModel.Layout.movieDescriptionMarginVer)
        ])
    }
    
    private func setUpNavBar() {
        navigationTitleObservable
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}
