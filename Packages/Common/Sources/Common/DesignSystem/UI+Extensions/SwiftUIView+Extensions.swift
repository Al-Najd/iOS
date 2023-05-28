//
//  SwiftUIView+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 28/11/2022.
//

import SwiftUI

public extension View {
    /// Closure given view and unwrapped optional value if optional is set.
    /// - Parameters:
    ///   - conditional: Optional value.
    ///   - content: Closure to run on view with unwrapped optional.
    @ViewBuilder
    func iflet<Content: View, T>(
        _ conditional: T?,
        @ViewBuilder _ content: (Self, _ value: T) -> Content)
        -> some View {
        if let value = conditional {
            content(self, value)
        } else {
            self
        }
    }

    /// Closure given view and unwrapped optional value if optional is set.
    /// - Parameters:
    ///   - conditional: Optional value.
    ///   - content: Closure to run on view with unwrapped optional.
    @ViewBuilder
    func shadow(_ shadow: Shadow) -> some View {
        self.shadow(color: Color(shadow.color).opacity(Double(shadow.opacity)), radius: shadow.blur, x: shadow.x, y: shadow.y)
    }

    func addDefaultModifiers(
        foreGroundColor: Color,
        backGroundColor: Color,
        textBoxWidth: Double,
        textBoxHeight: Double)
        -> some View {
        font(Font(UIFont.headerLarge()))
            .foregroundColor(foreGroundColor)
            .frame(width: textBoxWidth, height: textBoxHeight)
            .background(backGroundColor)
            .cornerRadius(16)
    }

    func addStrokeBorder() -> some View {
        overlay(RoundedRectangle(cornerRadius: 15.0).strokeBorder(Color(UIColor.tealPrimaryTeal), lineWidth: 1.0))
            .padding(3.0)
            .overlay(RoundedRectangle(cornerRadius: 18.0).strokeBorder(Color(UIColor.tealSuperlight), lineWidth: 3.0))
    }

    func shake(shouldShake: Bool) -> some View {
        modifier(ShakeEffect(shakes: shouldShake ? 2 : 0))
            .animation(shouldShake ? SwiftUI.Animation.linear : nil)
    }
}
