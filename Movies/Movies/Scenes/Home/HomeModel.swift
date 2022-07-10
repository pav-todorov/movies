//
//  HomeModel.swift
//  Movies
//
//  Created by Pavel on 8.07.22.
//

import UIKit

// MARK: - Home Model
struct HomeModel {
    // MARK: Initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var moviesTableViewCellWidth: CGFloat { 50 }
        static var moviesTableViewCellHeightMultiplier: CGFloat { 0.2 }
        
        static var segmentedControlMarginTop: CGFloat { 50 }
        
        static var moviesTableViewMarginTop: CGFloat { 20 }
        
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
}

