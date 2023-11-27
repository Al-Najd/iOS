//
//  ScrollViewRTL.swift
//
//
//  Created by Ahmed Ramy on 29/08/2022.
//

import SwiftUIIntrospect
import SwiftUI

public struct ScrollViewRTL<Content: View>: View {
    @ViewBuilder var content: Content
    @Environment(\.layoutDirection) private var layoutDirection

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    @ViewBuilder public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            content
                .rotation3DEffect(Angle(degrees: layoutDirection == .rightToLeft ? -180 : 0), axis: (
                    x: CGFloat(0),
                    y: CGFloat(layoutDirection == .rightToLeft ? -10 : 0),
                    z: CGFloat(0)))
        }
        .introspect(.scrollView, on: .iOS(.v17)) { scrollView in
            scrollView.clipsToBounds = false
        }
        .rotation3DEffect(Angle(degrees: layoutDirection == .rightToLeft ? 180 : 0), axis: (
            x: CGFloat(0),
            y: CGFloat(layoutDirection == .rightToLeft ? 10 : 0),
            z: CGFloat(0)))
    }
}
