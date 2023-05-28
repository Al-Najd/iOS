//
//  Percent.swift
//  CAFU
//
//  Created by Ahmed Ramy on 03/10/2022.
//

import Foundation

// MARK: - Percent

public struct Percent {
    public var value: Double

    public func display(isPrecise: Bool = false) -> String {
        PercentageFormatter(isPrecise: isPrecise).string(from: NSNumber(value: value)) ?? "%\(value)"
    }

    public init(value: Double) {
        // bound range between 0 - 1
        self.value = max(0, min(value, 1))
    }
}

// MARK: - Utilities
public extension Double {
    func asPercent() -> Percent {
        .init(value: self)
    }
}

public extension Percent {
    static let zero = Percent(value: 0.0)
}

public extension Percent {
    static func + (left: Percent, right: Percent) -> Percent {
        .init(value: left.value + right.value)
    }

    static func - (left: Percent, right: Percent) -> Percent {
        .init(value: left.value - right.value)
    }
}
