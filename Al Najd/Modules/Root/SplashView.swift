//
//  SplashView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/01/2022.
//

import SwiftUI

import ComposableArchitecture

// struct Splash: ReducerProtocol {
//  @Dependency(\.prayersDB)
//  private var prayersDB
//
//  init() { }
//
//  struct State: Equatable {
//    var canProceed: Bool = false
//  }
//
//  enum Action {
//    case onAppear
//  }
// }

struct SplashView<Content: View>: View {
    @State var showAnimation = false
    @State var showFooterText = false
    @State var endSplashFlow = false
    @State var showNextFlow = false

    private let injectedView: () -> Content

    public init(@ViewBuilder injectedView: @escaping () -> Content) {
        self.injectedView = injectedView
    }

    var body: some View {
        ZStack {
            injectedView()
                .offset(y: endSplashFlow ? 0 : -getScreenSize().height)

            VStack {
                // Lottie Wrapping Begins
                LottieView(
                    animation: .splash,
                    animationFramesHandlers: [
                        makeShowingFootersHandler(),
                        makeTransitioningToAppHandler(),
                    ])
                    .opacity(showAnimation ? 1 : 0)
                    .scaleEffect(showAnimation ? 1 : .ulpOfOne)
                // Lottie Wrapping Ends

                if showFooterText {
                    Text("Al Najd".localized)
                        .foregroundColor(.primary.dark)
                        .opacity(showFooterText ? 1 : 0)
                        .offset(y: showFooterText ? 0 : 100)
                        .padding()
                        .scaledFont(.pLargeTitle, .bold)

                    Text("Al Najd Aya".localized)
                        .scaledFont(
                            FontManager
                                .shared
                                .getFont(
                                    locale: .arabic,
                                    type: .sansSerif,
                                    category: .display,
                                    scale: .large,
                                    weight: .bold))
                        .foregroundColor(.success.default)
                        .opacity(showFooterText ? 1 : 0)
                        .offset(y: showFooterText ? 0 : 100)

                    Text("Al Najd Translation".localized)
                        .scaledFont(.pTitle2, .bold)
                        .foregroundColor(.mono.label)
                        .multilineTextAlignment(.center)
                        .opacity(showFooterText ? 1 : 0)
                        .offset(y: showFooterText ? 0 : 100)
                        .padding(.p24)
                }
            }.onAppear {
                after(seconds: 0.15) {
                    withAnimation(.spring()) {
                        showAnimation = true
                    }
                }
            }.offset(y: endSplashFlow ? getScreenSize().height : 0)
        }.background(
            Color("96A8B1")
                .ignoresSafeArea())
    }

    func makeShowingFootersHandler() -> AnimationHandler {
        .init(startFrame: 0, endFrame: 80, onComplete: { didFinish in
            guard didFinish else { return }
            withAnimation(.spring()) {
                showFooterText = true
            }
        })
    }

    func makeTransitioningToAppHandler() -> AnimationHandler {
        .init(startFrame: 80, endFrame: 147, onComplete: { didFinish in
            guard didFinish else { return }
            withAnimation(.easeInOut(duration: 0.65)) {
                endSplashFlow = true
            }

            withAnimation(.spring().delay(0.65)) {
                showNextFlow = true
            }
        })
    }
}
