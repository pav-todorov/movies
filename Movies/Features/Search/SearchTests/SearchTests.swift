//
//  SearchTests.swift
//  SearchTests
//
//  Created by Pavel on 8.07.22.
//

import Extensions
import Shared_Models
import XCTest
@testable import Search

class when_searching_a_movie: XCTestCase {
    
    func test_should_return_movie_entity_publisher() {
        let query = SearchMovieNetworkGeteway().fetch(with: .init(query: "Minions"))
        
        XCTAssertNotNil(query)
    }
    
    func test_should_make_sure_received_results_total_is_as_expected(){
        _ = SearchMovieNetworkGeteway().fetch(with: .init(query: "Minions"))
            .sink { _ in } receiveValue: { movieEntity in
                XCTAssertEqual(movieEntity.totalResults, movieEntity.results.count)
            }
    }
}
