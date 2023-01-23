//
//  RemindersView.swift
//  Reminders
//
//  Created by Ahmed Ramy on 23/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import SwiftUI
import uDesignSystem

public struct RemindersView: View {
    public init() { }

    public var body: some View {
        VStack {
            Text("5 Mins Of Zekr")
                .font(.mobileDisplayLarge())
                .foregroundColor(.grayscaleBackground)

            GeometryReader { proxy in
                VStack(spacing: .s16) {
                    ZStack {
                        Circle()
                    }
                    .padding(.s8 * 8)
                    .frame(width: proxy.size.width)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .background(Color.grayscaleHeader)
        .preferredColorScheme(.dark)
    }
}
