//
//  HomeViewController.swift
//  Movies
//
//  Created by Pavel Todorov on 8.07.22.
//

import UIKit
import RxSwift
import RxCocoa
import FluentUI
import Shared_Models

// MARK: - Home View Controller
final class HomeViewController:
    UIViewController,
    HomeViewable, HomeNavigable
{
    // MARK: Subviews
    private lazy var segmentedControl: FluentUI.SegmentedControl = {
        let segmentItems: [FluentUI.SegmentItem] = [
                SegmentItem(title: "Now Playing"),
                SegmentItem(title: "Popular"),
                SegmentItem(title: "Top Rated"),
                SegmentItem(title: "Upcoming")
            ]
        
        let segmentedControl = FluentUI.SegmentedControl(items: segmentItems, style: .primaryPill)
        segmentedControl.addTarget(self, action: #selector(didTapSegment(forControl:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }()
    
    // TODO: Add shimmer
    lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0
        return tableView
    }()
    
    // MARK: Properties
    var presenter: (any HomePresentable)!
    
    var disposeBag = DisposeBag()
    var moviesTableItemsObservable = PublishSubject<MovieResultEntity>()
    var moviePostersObservable = PublishSubject<GetPosterImageEntity>()
    
    private typealias UIModel = HomeModel

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
//        let source1 = moviesTableItemsObservable.asObservable()
//            .map({ $0 as AnyObject })
//
//        let source2 = moviePostersObservable.asObservable()
//            .map({ $0 as AnyObject })
//
//        let trueSource = Observable.of(source1, source2)
//        trueSource.merge()
        
        moviesTableItemsObservable
            .compactMap({ $0.results })
            .bind(to: moviesTableView.rx.items(
                cellIdentifier: TableViewCell.identifier,
                cellType: TableViewCell.self)) { [weak self] row, movieModel, cell in
                    var configuration = cell.defaultContentConfiguration()
                    configuration.text = "\(movieModel.title)"
                    configuration.imageProperties.maximumSize = CGSize(width: 50, height: UIScreen.main.bounds.height * 0.2)
                    
                    self?.presenter?.getPosterImage(parameters: .init(posterURL: movieModel.posterPath))
                        .observe(on: MainScheduler.instance)
                        .subscribe(onNext: { posterEntity in
                            configuration.image = posterEntity.image
                        })
                        .dispose()
                    
                    cell.contentConfiguration = configuration
            }
                .disposed(by: disposeBag)
        
        moviesTableView.rx.modelSelected(MovieResultEntity.Movie.self)
            .bind { [weak self] tappedMovie in
                self?.presenter.didTapMovie
                    .onNext(tappedMovie)
            }
            .disposed(by: disposeBag)
        
//        moviePostersObservable
//            .observe(on: MainScheduler.instance)
//            .asDriver(onErrorJustReturn: .init(image: nil))
//            .compactMap({ [$0.image] })
//            .drive(moviesTableView.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { row, image, cell in
//                var configuration = cell.defaultContentConfiguration()
//                configuration.image = image
//                cell.contentConfiguration = configuration
//            }
//            .disposed(by: disposeBag)
    }
    
    private func setUpView() {
        view.backgroundColor = UIModel.Colors.background
    }
    
    private func addSubviews() {
        view.addSubview(segmentedControl)
        view.addSubview(moviesTableView)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpNavBar() {
        navigationItem.title = "Home"
    }

    // MARK: Viewable

    // MARK: Navigable

    // MARK: Observers
    @objc private func didTapSegment(forControl control: FluentUI.SegmentedControl){
        switch control.selectedSegmentIndex {
        case 0: presenter.didTapSegment.onNext(HomeViewController.SegmentedControl.NowPlaying)
        case 1: presenter.didTapSegment.onNext(HomeViewController.SegmentedControl.Popular)
        case 2: presenter.didTapSegment.onNext(HomeViewController.SegmentedControl.TopRated)
        case 3: presenter.didTapSegment.onNext(HomeViewController.SegmentedControl.Upcoming)
        default:
            return
        }
    }
}
