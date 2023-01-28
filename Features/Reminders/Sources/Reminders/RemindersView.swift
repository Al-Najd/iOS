//
//  RemindersView.swift
//  Reminders
//
//  Created by Ahmed Ramy on 23/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import uDesignSystem
import uEntities

// MARK: - RemindersView

public struct RemindersView: View {
    let store: StoreOf<Reminders>

    @ObservedObject var viewStore: ViewStore<ViewState, Reminders.Action>

    struct ViewState: Equatable {
        let progress: Double
        let title: String
        let time: String

        init(state: Reminders.State) {
            progress = state.progress.value
            title = state.didFinish ? "Well Done!" : "5 Mins of Azkar"
            time = Countdown(startDate: state.startDate, endDate: state.endDate).display()
        }
    }

    public init(store: StoreOf<Reminders>) {
        self.store = store
        viewStore = ViewStore(self.store.scope(state: ViewState.init))
    }

    public var body: some View {
        VStack {
            Text(viewStore.title)
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
                            .trim(from: 0, to: viewStore.progress)
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
                            .trim(from: 0, to: viewStore.progress)
                            .stroke(
                                Color.primaryDefault.opacity(0.7),
                                lineWidth: 10)

                        Text(viewStore.time)
                            .font(.mobileDisplayHuge())
                            .bold()
                            .rotationEffect(.degrees(90))
                    }
                    .padding(.s8 * 8)
                    .frame(width: proxy.size.width)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: viewStore.progress)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .background {
            Color.grayscaleHeaderWeak.ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
        .onAppear {
            viewStore.send(.start)
        }
    }
}

// MARK: - RemindersView_Previews

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView(
            store: .init(initialState: .init(startDate: .now), reducer: Reminders()))
    }
}

// MARK: - RemindersView.UIModel

extension RemindersView {
    struct UIModel {
        @State var progress: CGFloat = 1
        @State var timeLeft = "00:00"
    }
}
