//
//  RemindersView.swift
//  Reminders
//
//  Created by Ahmed Ramy on 23/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import SwiftUI
import uDesignSystem

// MARK: - RemindersView

public struct RemindersView: View {
    @State var progress = 1.0
    @State var text = "00:00"

    public init() { }

    public var body: some View {
        VStack {
            Text("5 Mins Of Zekr")
                .font(.mobileDisplayLarge())
                .bold()
                .foregroundColor(.grayscaleBackground)

            GeometryReader { proxy in
                VStack(spacing: .s16) {
                    ZStack {
                        Circle()
                            .fill(Color.grayscaleBackground.opacity(0.03))
                            .padding(-.s40)

                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(Color.grayscaleBackground.opacity(0.03), lineWidth: .s40 + .s40)
                            .blur(radius: .r16)
                            .padding(-.s4)

                        // MARK: - Shadow
                        Circle()
                            .stroke(
                                Color.primaryDefaultWeak,
                                lineWidth: 5)
                            .blur(radius: .r16)
                            .padding(-.s4)

                        Circle()
                            .fill(Color.grayscaleHeaderWeak)
                            .blur(radius: .r16)
                            .padding(-.s4)

                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                Color.primaryDefault.opacity(0.7),
                                lineWidth: 10)

                        Text(text)
                            .font(.mobileDisplayHuge())
                            .bold()
                            .rotationEffect(.degrees(90))
                    }
                    .padding(.s8 * 8)
                    .frame(width: proxy.size.width)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: progress)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .background {
            Color.grayscaleHeaderWeak.ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - RemindersView_Previews

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}

// MARK: - RemindersView.UIModel

extension RemindersView {
    struct UIModel {
        @State var progress: CGFloat = 1
        @State var timeLeft = "00:00"
    }
}
