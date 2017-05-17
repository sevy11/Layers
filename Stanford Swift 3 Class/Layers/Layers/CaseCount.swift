//
//  CaseCount.swift
//  Layers
//
//  Created by Michael Sevy on 5/14/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import Foundation

/**
    A protocol that defines count
    generation for an enum.
 */
protocol CaseCount {
    static var caseCount: Int { get }
    static func numberOfCases() -> Int
}


/**
    Provides a default implementation of `numberOfCases()`
    when the enum type is `Int`.
 */
extension CaseCount where Self : RawRepresentable, Self.RawValue == Int {
    static func numberOfCases() -> Int {
        var count = 0
        while let _ = Self(rawValue: count) { count += 1 }
        return count
    }
}
