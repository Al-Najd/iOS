//
//  Dictionary+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 28/12/2022.
//

import Foundation

public extension Dictionary {
    static func + (_ lhs: Self, rhs: Self) -> Self {
        lhs.merging(rhs, uniquingKeysWith: { _, new in new })
    }
}
