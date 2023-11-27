//
//  File.swift
//
//
//  Created by Ahmed Ramy on 26/03/2023.
//

import ComposableArchitecture
import Inject
import SwiftUI

// MARK: - AzkarView

public struct AzkarView: View {
    @ObserveInjection var inject
    let store: StoreOf<Azkar>
    @ObservedObject var viewStore: ViewStoreOf<Azkar>
    @State var isShowingMorningAzkar: Bool = true

    public init(store: StoreOf<Azkar>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            makeTimingSelectionSection()
            ScrollView {
                ForEach(
                    isShowingMorningAzkar
                    ? viewStore.morningAzkar
                    : viewStore.nightAzkar
                ) { zekr in
                    ZekrView(title: zekr.name, subtitle: zekr.reward, repetation: zekr.currentCount) {
                        viewStore.send(.onDoingMorning(zekr), animation: .default)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, .p8)
                }
            }
            .padding(.p8)
            .background(
                Color.primaryBlackberry
                    .cornerRadius(.r16)
                    .padding(.p8)

            )
        }
        .fill()
        .background(Color.mono.background.ignoresSafeArea())
        .onAppear { viewStore.send(.onAppear, animation: .default) }
        .enableInjection()
    }

    @ViewBuilder
    func makeTimingSelectionSection() -> some View {
        VStack(alignment: .leading, spacing: .p8) {
            ScrollViewRTL {
                HStack {
                    GeometryReader { geometry in
                        ZekrCategoryView(
                            title: "الصباح",
                            image: Asset.Prayers.Faraaid.dhuhrImage,
                            isSelected: $isShowingMorningAzkar
                        ) {
                            withAnimation { isShowingMorningAzkar = true }
                        }
                            .rotation3DEffect(
                                .degrees(
                                    ((.p8 + geometry.frame(in: .local).width) / 2 - geometry.frame(in: .global).minX) /
                                    30.0),
                                axis: (x: 0, y: -5, z: 0))
                    }
                    .frame(width: 145, height: 210)
                    .padding(.horizontal, .p16)

                    GeometryReader { geometry in
                        ZekrCategoryView(
                            title: "المساء",
                            image: Asset.Prayers.Faraaid.ishaImage,
                            isSelected: .init(get: { !isShowingMorningAzkar }, set: { isShowingMorningAzkar = !$0 })
                        ) { withAnimation { isShowingMorningAzkar = false } }
                            .rotation3DEffect(
                                .degrees(
                                    ((.p8 + geometry.frame(in: .local).width) / 2 - geometry.frame(in: .global).minX) /
                                    30.0),
                                axis: (x: 0, y: -5, z: 0))
                    }
                    .frame(width: 145, height: 210)
                    .padding(.horizontal, .p16)
                }
            }
        }.padding()
    }
}


// MARK: - ZekrView

struct ZekrView: View {
    var title: String
    var subtitle: String
    var repetation: Int
    var isDone: Bool { repetation == .zero }
    var onDoing: () -> Void

    init(title: String, subtitle: String, repetation: Int, onDoing: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.repetation = repetation
        self.onDoing = onDoing
    }

    var body: some View {
        VStack {
            VStack(spacing: .p16) {
                Spacer()

                ZStack(alignment: .top) {
                    VStack {
                        Text(title)
                            .padding()
                            .foregroundColor(.mono.offwhite)
                            .scaledFont(.pFootnote, .regular)
                            .fillAndCenter()
                            .multilineTextAlignment(.center)
                            .padding(.top)
                    }
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [.white.opacity(0.5), .clear],
                                    startPoint: .top,
                                    endPoint: .bottom)))
                    .zIndex(0)

                    Button(action: onDoing, label: {
                        Group {
                            statusView
                                .foregroundStyle(
                                    .linearGradient(
                                        colors: [
                                            .white,
                                            .clear
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing))
                                .background(
                                    HexagonShape()
                                        .stroke()
                                        .foregroundStyle(
                                            .linearGradient(
                                                colors: [
                                                    .white.opacity(0.5),
                                                    .clear
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing)))
                                .background(
                                    HexagonShape()
                                        .foregroundStyle(
                                            .linearGradient(
                                                colors: [
                                                    .clear,
                                                    .white.opacity(0.3),
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing)))
                                .background(
                                    HexagonShape()
                                        .fill()
                                        .foregroundColor(.primarySpaceGrey))
                                .offset(y: -22 - 4)
                        }
                        .frame(width: .p24, height: .p24)
                        .padding()
                    })
                }.zIndex(3)

                if isDone {
                    VStack {
                        Text(subtitle)
                            .padding()
                            .foregroundColor(.success.light)
                            .scaledFont(.pFootnote, .regular)
                            .multilineTextAlignment(.center)
                            .fillAndCenter()
                            .padding(.top)
                    }
                    .background(Color.success.background.opacity(0.25))
                    .background(.ultraThinMaterial)
                    .opacity(0.75)
                    .cornerRadius(16)
                    .frame(maxWidth: getScreenSize().width * 0.75)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [.success.darkMode.opacity(0.5), .clear],
                                    startPoint: .top,
                                    endPoint: .bottom)))
                    .shadow(color: .success.darkMode.opacity(0.5), radius: 16, x: 0, y: 0)
                    .offset(y: isDone ? -40 : -100)
                    .zIndex(-5)
                }
            }
        }
        .onTapGesture(perform: onDoing)
    }

    @ViewBuilder
    var statusView: some View {
        if isDone {
            Image(systemName: "checkmark.seal.fill")
                .frame(width: 44, height: 44)
                .foregroundColor(.success.darkMode)
                .shadow(color: .success.darkMode.opacity(0.5), radius: 16, x: 0, y: 0)
        } else if repetation == 1 {
            Image(systemName: "square")
                .frame(width: 44, height: 44)
                .foregroundColor(.mono.offwhite)
                .shadow(color: .success.darkMode.opacity(0.5), radius: 16, x: 0, y: 0)
        } else {
            Text(repetation.formatted())
                .frame(width: 44, height: 44)
                .foregroundColor(.mono.offwhite)
                .shadow(color: .success.darkMode.opacity(0.5), radius: 16, x: 0, y: 0)
        }
    }
}

public struct ZekrCategoryView: View {
    let title: String
    let image: ImageAsset
    @Binding var isSelected: Bool
    var onTapping: () -> Void

    public var body: some View {
        VStack {
            VStack {
                Spacer()

                ZStack(alignment: .top) {
                    VStack {
                        Text(title)
                            .padding()
                            .foregroundColor(.white)
                            .scaledFont(.pFootnote, .regular)
                            .lineLimit(2)
                            .fillAndCenter()
                    }
                    .background(.ultraThinMaterial)
                    .opacity(0.75)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [.white.opacity(0.5), .clear],
                                    startPoint: .top,
                                    endPoint: .bottom)))

                    if isSelected {
                        Image(systemName: "checkmark.seal.fill")
                            .frame(width: 44, height: 44)
                            .foregroundColor(.success.darkMode)
                            .shadow(color: .success.darkMode.opacity(0.5), radius: 16, x: 0, y: 0)
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [
                                        .white,
                                        .clear
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
                            .background(
                                HexagonShape()
                                    .stroke()
                                    .foregroundStyle(
                                        .linearGradient(
                                            colors: [
                                                .white.opacity(0.5),
                                                .clear
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing)))
                            .background(
                                HexagonShape()
                                    .foregroundStyle(
                                        .linearGradient(
                                            colors: [
                                                .clear,
                                                .white.opacity(0.3),
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing)))
                            .background(
                                HexagonShape()
                                    .fill()
                                    .foregroundColor(image.image.averageColor))
                            .offset(y: -22 - 4)
                    }
                }
            }
            .background(
                image
                    .swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fill))
            .cornerRadius(16)
            .shadow(
                color: image.image.averageColor,
                radius: 25,
                x: 0,
                y: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.white.opacity(0.25), image.image.averageColor, .clear],
                            startPoint: .top,
                            endPoint: .bottom)))
        }.onTapGesture {
            onTapping()
        }
    }
}
