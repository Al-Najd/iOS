//
//  Gradients+Extension.swift
//  CAFU
//
//  Created by Ahmed Ramy on 07/10/2022.
//

import SwiftUI

public extension LinearGradient {
    static let homeLowCharge: LinearGradient = .init(
        colors: [
            Color("Gradients/Home/LowCharge/ProgressStart"),
            Color("Gradients/Home/LowCharge/ProgressEnd")
        ],
        startPoint: .top,
        endPoint: .bottom)

    static let homeMidCharge: LinearGradient = .init(
        colors: [
            Color("Gradients/Home/MidCharge/ProgressStart"),
            Color("Gradients/Home/MidCharge/ProgressEnd")
        ],
        startPoint: .top,
        endPoint: .bottom)

    static let homeHighCharge: LinearGradient = .init(
        colors: [
            Color("Gradients/Home/HighCharge/ProgressStart"),
            Color("Gradients/Home/HighCharge/ProgressEnd")
        ],
        startPoint: .top,
        endPoint: .bottom)

    static let orderDetailsProgressCharge: LinearGradient = .init(
        colors: [
            Color("Gradients/Order Details/Progress Charge/ProgressStart"),
            Color("Gradients/Order Details/Progress Charge/ProgressEnd")
        ],
        startPoint: .top,
        endPoint: .bottom)
}

// MARK: - Utilities
public extension LinearGradient {
    static let none = LinearGradient(colors: [], startPoint: .top, endPoint: .bottom)
}
