//
//  File.swift
//
//
//  Created by Ahmed Ramy on 05/04/2023.
//

import Foundation
import Lottie

public extension Animation {
    static let loading: Self = .init(name: "ThreeDotsLoadingAnimation", mode: .loop, contentMode: .scaleAspectFill)

    // MARK: - General
    static let none: Animation = .init(name: "", mode: .loop, contentMode: .scaleAspectFit)
}
