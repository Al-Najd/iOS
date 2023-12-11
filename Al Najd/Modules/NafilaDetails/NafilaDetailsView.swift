//
//  SwiftUIView.swift
//
//
//  Created by Ahmed Ramy on 11/04/2023.
//

import ComposableArchitecture

import Drawer

import Inject


import SwiftUI


// MARK: - NafilaDetailsView

public struct NafilaDetailsView: View {
    @ObserveInjection var inject
    let store: StoreOf<NafilaDetails>
    @ObservedObject var viewStore: ViewStoreOf<NafilaDetails>

    public init(store: StoreOf<NafilaDetails>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Label(viewStore.date, systemImage: "calendar")
                        .foregroundColor(.mono.offwhite)
                        .scaledFont(.pFootnote)
                        .multilineTextAlignment(.center)

                    Spacer()

                    Button {
                        viewStore.send(.dismiss, animation: .default)
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .foregroundColor(.mono.offwhite)
                            .scaledFont(.pFootnote)
                            .frame(width: 12, height: 12)
                            .padding(.p8)
                            .background(
                                Circle()
                                    .foregroundColor(.mono.offwhite.opacity(0.25)))
                    }
                }.padding()

                Text(viewStore.nafila.title)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(locale: .arabic, .pBody)
                    .multilineTextAlignment(.center)
                Spacer()
            }

            Drawer(startingHeight: 50) {
                VStack {
                    NafilaTasksView(viewStore: viewStore)
                    Spacer()
                }
            }
            .rest(at: .constant(
                [
                    50,
                    0.25.asPercentage(),
                    0.5.asPercentage(),
                ]))
            .impact(.heavy)
            .spring(.p32)
            .padding(.bottom, getSafeArea().bottom)
            .padding(.bottom, .p16)

        }.background(
            viewStore.nafila.image
                .swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .overlay(
                    Color.mono.offblack.opacity(0.5)))
        .enableInjection()
    }
}

// MARK: - NafilaTasksView

struct NafilaTasksView: View {
    let viewStore: ViewStoreOf<NafilaDetails>

    @State var tab = 0

    var body: some View {
        ZStack {
            BlurView(.systemChromeMaterialDark)
                .cornerRadius(.r24 + .r8)
                .shadow(radius: 100)

            VStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 3.0)
                    .foregroundColor(.gray)
                    .frame(width: 30.0, height: 6.0)
                    .padding(.top, .p4)
                    .padding(.bottom, .p8)

                NafilaSubtaskView(viewStore.nafila) {
                    viewStore.send(.onDoingNafila, animation: .default)
                }

                Spacer()
            }
            .padding(.top)
        }
    }
}

// MARK: - NafilaSubtaskView

struct NafilaSubtaskView: View {
    var title: String
    var subtitle: String
    var isDone: Bool
    var onDoing: () -> Void

    init(_ nafila: Nafila, onDoing: @escaping () -> Void) {
        title = nafila.title
        subtitle = nafila.subtitle
        isDone = nafila.isDone
        self.onDoing = onDoing
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote, .bold)
                    .multilineTextAlignment(.leading)
                Text(subtitle)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote)
                    .multilineTextAlignment(.leading)
            }

            Spacer()

            Button(action: onDoing, label: {
                Image(systemName: isDone ? "checkmark.square.fill" : "square")
                    .resizable()
                    .foregroundColor(
                        isDone
                            ? .success.darkMode
                            : .mono.offwhite)
                        .frame(width: .p24, height: .p24)
                        .padding()
                        .background(
                            Circle()
                                .foregroundColor(
                                    isDone
                                        ? .success.light.opacity(0.25)
                                        : .mono.offwhite.opacity(0.1)))
            })
        }
        .padding(.horizontal, .p16)
        .padding(.bottom, .p8)
        .onTapGesture(perform: onDoing)
    }
}
