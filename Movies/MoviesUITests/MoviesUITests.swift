//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Pavel Todorov on 8.07.22.
//

import XCTest

class when_app_is_launched: XCTestCase {
    
    func test_should_display_all_segments_text_in_english_correctly() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let _ = app.segmentedControls["segmentedControl"].waitForExistence(timeout: 5.0)
        
        XCTAssertTrue(app.buttons["Popular"].staticTexts["Popular"].waitForExistence(timeout: 1.0))
        XCTAssertTrue(app.buttons["Now Playing"].staticTexts["Now Playing"].waitForExistence(timeout: 1.0))
        XCTAssertTrue(app.buttons["Top Rated"].staticTexts["Top Rated"].waitForExistence(timeout: 1.0))
        XCTAssertTrue(app.buttons["Upcoming"].staticTexts["Upcoming"].waitForExistence(timeout: 1.0))
    }
}
