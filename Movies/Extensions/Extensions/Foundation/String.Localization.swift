//
//  String.Localization.swift
//  Extensions
//
//  Created by Pavel on 10.07.22.
//

import Foundation

// MARK: - Localized String
public extension String {
    func localized(for bundleId: Bundle? = nil) -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
