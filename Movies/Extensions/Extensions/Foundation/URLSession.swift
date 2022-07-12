//
//  URLSession.swift
//  Extensions
//
//  Created by Pavel on 9.07.22.
//

import RxSwift
import RxCocoa
import Combine
import UIKit

public struct Resources<T> {
    // MARK: Properties
    public let url: URL
    
    // MARK: Initializer
    public init(url: URL) {
        self.url = url
    }
}

// MARK: RxSwift Specific
public extension URLRequest {
    // TODO: Add caching
    static func load<T: Decodable>(resources: Resources<T>) -> Observable<T> {
        return Observable.from([resources.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }
            .map { data in
                return try JSONDecoder().decode(T.self, from: data)
            }
            .asObservable()
    }
    
    static func loadImage(resources: Resources<Any>) -> Observable<UIImage?> {
        return Observable.from([resources.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }
            .map { data in
                return UIImage(data: data)
            }
            .asObservable()
    }
}

// MARK: Combine Specific
public extension URLRequest {
    // TODO: Add caching
    static func load<T: Decodable>(resources: Resources<T>) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: resources.url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
