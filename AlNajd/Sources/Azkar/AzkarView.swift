//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 26/03/2023.
//

import SwiftUI
import Utils
import Common
import DesignSystem
import ReusableUI
import Inject
import Entity
import ComposableArchitecture
import Localization

public struct AzkarView: View {
    @ObserveInjection var inject
    var store: StoreOf<Azkar>

    public init(store: StoreOf<Azkar>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                VStack {
                    Text(L10n.azkarAlSabah)
                        .foregroundColor(.mono.offblack)
                        .scaledFont(.pTitle2, .bold)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, .p16)

                    ForEach(viewStore.morningAzkar) { zekr in
                        ZekrView(title: zekr.name, subtitle: zekr.reward, repetation: zekr.currentCount) {
                            viewStore.send(.onDoingMorning(zekr), animation: .default)
                        }.padding()
                    }

                    Text(L10n.azkarAlMasaa)
                        .foregroundColor(.mono.offblack)
                        .scaledFont(.pTitle2, .bold)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, .p16)

                    ForEach(viewStore.nightAzkar) { zekr in
                        ZekrView(title: zekr.name, subtitle: zekr.reward, repetation: zekr.currentCount) {
                            viewStore.send(.onDoingNight(zekr), animation: .default)
                        }.padding()
                    }
                }
            }
            .fill()
            .background(Color.mono.background.ignoresSafeArea())
            .onAppear { viewStore.send(.onAppear, animation: .default) }
        }
        .enableInjection()
    }
}


struct ZekrView: View {
    var title: String
    var subtitle: String
    var repetation: Int
    var isDone: Bool { repetation == .zero }
    var onDoing: () -> Void

    var body: some View {
        VStack {
            HStack(spacing: .p16) {
                Text(title)
                    .foregroundColor(.mono.offblack)
                    .scaledFont(.pFootnote, .bold)
                    .multilineTextAlignment(.leading)

                Spacer()

                Button(action: onDoing, label: {
                    Group {
                        if isDone {
                            Image(systemName: "checkmark.square.fill")
                                .resizable()
                                .foregroundColor(
                                    .success.default)
                        } else if repetation == 1 {
                            Image(systemName: "square")
                                .resizable()
                                .foregroundColor(.mono.offblack)
                                .frame(width: .p24, height: .p24)
                                .padding()
                        } else {
                            Text(repetation.formatted())
                                .foregroundColor(.mono.offblack)
                                .scaledFont(.pFootnote, .bold)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(width: .p24, height: .p24)
                    .padding()
                    .background(
                        Circle()
                            .foregroundColor(
                                isDone
                                ? .success.dark.opacity(0.25)
                                : .mono.offblack.opacity(0.1)))
                })
            }

            Text(subtitle)
                .foregroundColor(.mono.offblack)
                .scaledFont(.pFootnote)
                .multilineTextAlignment(.leading)
                .fillOnLeading()
        }
        .padding()
        .background(
            RoundedRectangle(cornerSize: .init(width: CGFloat.r8, height: CGFloat.r8))
                .foregroundColor(.mono.input)
                .shadow(radius: .r8)
        )
        .onTapGesture(perform: onDoing)
    }
}
