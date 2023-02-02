//
//  CountdownFormatter.swift
//  uEntities
//
//  Created by Ahmed Ramy on 28/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - CountdownFormatter

public class CountdownFormatter: DateComponentsFormatter {
    override public init() {
        super.init()
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        allowedUnits = [.minute, .second]
        zeroFormattingBehavior = .pad
    }

    public func format(for startDate: Date, endDate: Date) -> String {
        string(from: startDate, to: endDate) ?? "00:00"
    }
}

// MARK: DependencyKey

extension CountdownFormatter: DependencyKey {
    public static let liveValue = CountdownFormatter()
}

public extension DependencyValues {
    var countdownFormatter: CountdownFormatter {
        get { self[CountdownFormatter.self] }
        set { self[CountdownFormatter.self] = newValue }
    }
}
