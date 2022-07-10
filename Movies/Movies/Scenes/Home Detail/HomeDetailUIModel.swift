//  
//  HomeDetailUIModel.swift
//  Movies
//
//  Created by Pavel on 9.07.22.
//

import UIKit

// MARK: - HomeDetail UI Model
struct HomeDetailUIModel {
    // MARK: Initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var posterViewHeight: CGFloat { UIScreen.main.bounds.height * 0.7 }
        
        static var movieDescriptionMarginHor: CGFloat { 10 }
        static var movieDescriptionMarginVer: CGFloat { 30 }
        static var movieDescriptionHeight: CGFloat { 500 }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Colors
    struct Colors {
        // MARK: Properties
        static var background: UIColor? { .systemBackground }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Fonts
    struct Fonts {
        // MARK: Properties
        static var movieDescriptionTextView: UIFont? { UIFont(descriptor: .init(), size: 18) }
        
        // MARK: Initializers
        private init() {}
    }
}
