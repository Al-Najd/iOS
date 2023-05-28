//
//  Animation.swift
//  CAFU
//
//  Created by Ahmed Ramy on 03/10/2022.
//

import Lottie
import UIKit

// MARK: - Animation

public struct Animation: Equatable {
    public let name: String
    public let mode: LottieLoopMode
    public let contentMode: UIView.ContentMode

    public init(
        name: String,
        mode: LottieLoopMode,
        contentMode: UIView.ContentMode) {
        self.name = name
        self.mode = mode
        self.contentMode = contentMode
    }

    public static func == (lhs: Animation, rhs: Animation) -> Bool {
        lhs.name == rhs.name &&
            lhs.mode == rhs.mode &&
            lhs.contentMode == rhs.contentMode
    }
}
