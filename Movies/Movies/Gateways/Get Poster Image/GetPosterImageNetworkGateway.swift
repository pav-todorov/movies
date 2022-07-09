//
//  GetPosterImageNetworkGateway.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import UIKit
import RxSwift
import Extensions

// MARK: Get Poster Image Network Gateway
final class GetPosterImageNetworkGateway: GetPosterImageGatewayable {
    // MARK: Properties
    static let shared: GetPosterImageNetworkGateway = .init()
    
    let disposeBag = DisposeBag()
    
    private let cache: NSCache<NSString, UIImage> = {
        let cache: NSCache<NSString, UIImage> = .init()
        cache.countLimit = 100
        return cache
    }()
    
    // MARK: Initializers
    private init() {}
    
    // MARK: Gatewayable
    func fetch(with parameters: GetPosterImageParameters) -> Observable<GetPosterImageEntity> {
        switch cache.object(forKey: .init(string: parameters.posterURL)) {
        case nil:
            guard let url = URL(string: "\(Keys.baseImageURL)\(parameters.posterURL)") else { return Observable.just(.init(image: nil)) }
            
                let observableEntity =  URLRequest.loadImage(resources: Resources(url: url))
                    .observe(on: MainScheduler.instance)
                    .compactMap({ .init(image: $0) })
                    .catch { error -> Observable<GetPosterImageEntity> in
                        return Observable.just(GetPosterImageEntity(image: nil))
                    }
                
                observableEntity.subscribe { [weak self] posterEntity in
                    if let image = posterEntity.element?.image {
                        self?.cache.setObject(image, forKey: .init(string: parameters.posterURL))
                    }
                }
                .disposed(by: disposeBag)
                
                return observableEntity
            
        case let image?: return Observable.just(.init(image: image))
        }
    }
}
