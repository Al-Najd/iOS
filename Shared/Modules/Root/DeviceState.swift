//
//  File.swift
//
//
//  Created by Ahmed Ramy on 03/03/2022.
//

import SwiftUI
import UIKit

// MARK: - DeviceState

public struct DeviceState {
    public var idiom: UIUserInterfaceIdiom
    public var orientation: UIDeviceOrientation
    public var previousOrientation: UIDeviceOrientation

    public static let `default` = Self(
        idiom: UIDevice.current.userInterfaceIdiom,
        orientation: UIDevice.current.orientation,
        previousOrientation: UIDevice.current.orientation)

    public var isPad: Bool {
        idiom == .pad
    }

    public var isPhone: Bool {
        idiom == .phone
    }

    #if DEBUG
    public static let phone = Self(
        idiom: .phone,
        orientation: .portrait,
        previousOrientation: .portrait)

    public static let pad = Self(
        idiom: .pad,
        orientation: .portrait,
        previousOrientation: .portrait)
    #endif
}

// MARK: - DeviceStateModifier

public struct DeviceStateModifier: ViewModifier {
    @State var state: DeviceState = .default

    public init() { }

    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(
                NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    state.previousOrientation = state.orientation
                    state.orientation = UIDevice.current.orientation
            }
            .environment(\.deviceState, state)
    }
}

public extension EnvironmentValues {
    var deviceState: DeviceState {
        get { self[DeviceStateKey.self] }
        set { self[DeviceStateKey.self] = newValue }
    }
}

// MARK: - DeviceStateKey

private struct DeviceStateKey: EnvironmentKey {
    static var defaultValue: DeviceState {
        .default
    }
}
