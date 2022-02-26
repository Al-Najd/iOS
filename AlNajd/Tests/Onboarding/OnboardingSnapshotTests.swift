//
//  OnboardingSnapshotTests.swift
//  
//
//  Created by Ahmed Ramy on 18/02/2022.
//

import XCTest
import SnapshotTesting
import ComposableArchitecture
import Utils
import Calendar
import DesignSystem
import Onboarding
import SwiftUI
import Common

class OnboardingSnapshotTests: XCTestCase {
    static override func setUp() {
        super.setUp()
        SnapshotTesting.diffTool = "ksdiff"
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        //    isRecording = true
    }
    
    override func tearDown() {
        isRecording = false
        super.tearDown()
    }
    
    func testSteps() {
        
        let view = OnboardingView(
            store: .init(
                initialState: .init(step: .step000_ThereIsNoWayYouCanHide),
                reducer: .empty,
                environment: CoreEnvironment.live(OnboardingEnvironment())
            ),
            injectedView: { EmptyView() }
        )
        
        assertSnapshots(matching: view, as: [
            "Light": .image(
                layout: .device(config: .iPhoneXsMax),
                traits: .init(userInterfaceStyle: .light)
            ),
            "Dark": .image(
                layout: .device(config: .iPhoneXsMax),
                traits: .init(userInterfaceStyle: .dark)
            )
        ])
    }
}

extension OnboardingEnvironment {
    static let failing = Self.init()
}
    

extension View {
    func toUIVC() -> UIViewController {
        UIHostingController(rootView: self)
    }
}

/// Left-to-right, value-mutable function application.
///
/// - Parameters:
///   - a: A value.
///   - fs: In-out functions.
/// - Returns: The result of `f` applied to `a`.
/// - Note: This function is commonly seen in operator form as "pipe-forward", `|>`.
public func update<A>(_ a: A, _ fs: ((inout A) -> Void)...) -> A {
    var a = a
    fs.forEach { f in f(&a) }
    return a
}
