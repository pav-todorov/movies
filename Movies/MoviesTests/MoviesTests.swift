//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Pavel Todorov on 8.07.22.
//

import XCTest
import RxSwift
@testable import Movies

// MARK: - Movies Tests
class MoviesTests: XCTestCase {
    class presenting_home: XCTestCase {
        
        func test_should_return_image_entity_publisher() {
            let query = GetPosterImageNetworkGateway.shared.fetch(with: GetPosterImageParameters(posterURL: ""))
            
            XCTAssertNotNil(query)
        }
        
        func test_should_make_sure_received_results_total_is_as_expected(){
            let disposeBag = DisposeBag()
            GetPosterImageNetworkGateway.shared.fetch(with: GetPosterImageParameters(posterURL: ""))
                .subscribe { posterEntity in
                    XCTAssertNotNil(posterEntity)
                }
                .disposed(by: disposeBag)

        }
    }
}
