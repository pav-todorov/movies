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
            SegmentItem(title: LocStrings.Movies.modules_movies_now_playing_segment_title),
            SegmentItem(title: LocStrings.Movies.modules_movies_popular_segment_title),
            SegmentItem(title: LocStrings.Movies.modules_movies_top_rated_segment_title),
            SegmentItem(title: LocStrings.Movies.modules_movies_upcoming_segment_title)
            ]
        
        let segmentedControl = FluentUI.SegmentedControl(items: segmentItems, style: .primaryPill)
        segmentedControl.addTarget(self, action: #selector(didTapSegment(forControl:)), for: .valueChanged)
        segmentedControl.backgroundColor = .clear
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }()
    
    // TODO: Add shimmer
    lazy var moviesTableView: UITableView = {
        let tableView = UITableView(frame: .init(), style: .insetGrouped)
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
    
    private typealias UIModel = HomeModel
    private typealias LocStrings = LocalizedStrings.Modules

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
        moviesTableItemsObservable
            .compactMap({ $0.results })
            .bind(to: moviesTableView.rx.items(
                cellIdentifier: TableViewCell.identifier,
                cellType: TableViewCell.self)) { [weak self] row, movieModel, cell in
                    var configuration = cell.defaultContentConfiguration()
                    configuration.text = "\(movieModel.title)"
                    configuration.imageProperties.maximumSize = CGSize(width: UIModel.Layout.moviesTableViewCellWidth, height: UIScreen.main.bounds.height * UIModel.Layout.moviesTableViewCellHeightMultiplier)
                    
                    self?.presenter?.getPosterImage(parameters: .init(posterURL: movieModel.posterPath ?? ""))
                        .observe(on: MainScheduler.instance)
                        .compactMap({ $0.image })
                        .subscribe(onNext: { image in
                            configuration.image = image
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
        
        moviesTableView.rx.itemSelected
            .subscribe { [weak self] indexPath in
                self?.moviesTableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
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
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: UIModel.Layout.segmentedControlMarginTop),
            
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: UIModel.Layout.moviesTableViewMarginTop),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpNavBar() {
        navigationItem.title = LocStrings.Tabbar.modules_tabbar_home_title
    }

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
