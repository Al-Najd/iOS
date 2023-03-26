//
//  PrayerDetailsView.swift
//
//
//  Created by Ahmed Ramy on 10/08/2022.
//

import ComposableArchitecture
import DesignSystem
import Drawer
import Entities
import Inject
import Localization
import ReusableUI
import SwiftUI
import Utils

// MARK: - PrayerDetailsView

public struct PrayerDetailsView: View {
    @ObserveInjection var inject
    let store: StoreOf<PrayerDetails>

    public init(store: StoreOf<PrayerDetails>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
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

                    Text(viewStore.prayer.title)
                        .foregroundColor(.mono.offwhite)
                        .scaledFont(locale: .arabic, .pBody)
                        .multilineTextAlignment(.center)
                    Spacer()
                }

                Drawer(startingHeight: 50) {
                    TasksView(viewStore: viewStore)
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
                viewStore.prayer.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .overlay(
                        Color.mono.offblack.opacity(0.5)))
                .enableInjection()
        }
    }
}

extension Double {
    func asPercentage() -> CGFloat {
        getScreenSize().height * self
    }
}

extension CGFloat {
    func asPercentage() -> CGFloat {
        getScreenSize().height * self
    }
}

// MARK: - TasksView

struct TasksView: View {
    let viewStore: ViewStoreOf<PrayerDetails>

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

                TabView(selection: $tab) {
                    makeTasksList()
                    makeRewardsList()
                }.tabViewStyle(.page(indexDisplayMode: .never))
            }
            .padding(.top)
        }
    }

    @ViewBuilder
    func makeTasksList() -> some View {
        VStack {
            SubtaskView(viewStore.prayer) { viewStore.send(.onDoingPrayer, animation: .default) }
            ScrollView(.vertical, showsIndicators: false) {
                Text(L10n.sunnah)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote, .bold)
                    .multilineTextAlignment(.center)
                    .if(viewStore.prayer.sunnah.isEmpty, transform: { _ in EmptyView() })
                ForEach(viewStore.prayer.sunnah) { sunnah in
                    SubtaskView(sunnah) {
                        viewStore.send(.onDoingSunnah(sunnah), animation: .default)
                    }.frame(maxWidth: .infinity)
                }
                Text(L10n.azkar)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote, .bold)
                    .multilineTextAlignment(.center)
                ForEach(viewStore.prayer.afterAzkar) { zekr in
                    RepeatableSubtaskView(zekr) {
                        viewStore.send(.onDoingZekr(zekr), animation: .default)
                    }.frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, getSafeArea().bottom * 5)
        }
    }

    @ViewBuilder
    func makeRewardsList() -> some View {
        VStack {
            if viewStore.prayer.isDone {
                Text(L10n.alfard)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote, .bold)
                    .multilineTextAlignment(.center)
                RewardView(viewStore.prayer)
                if viewStore.prayer.sunnah.filter { $0.isDone }.count > 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        Text(L10n.sunnah)
                            .foregroundColor(.mono.offwhite)
                            .scaledFont(.pFootnote, .bold)
                            .multilineTextAlignment(.center)
                            .if(
                                viewStore.prayer.sunnah.isEmpty, transform: { _ in EmptyView() })
                        ForEach(viewStore.prayer.sunnah) { sunnah in
                            RewardView(sunnah)
                                .frame(maxWidth: .infinity)
                        }
                    }
                } else {
                    Spacer()
                }
            } else {
                Text("🤷‍♂️")
                    .scaledFont(.pLargeTitle, .bold)
                    .multilineTextAlignment(.center)
                Text(L10n.fardNotDoneYet)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pTitle1, .bold)
                    .multilineTextAlignment(.center)
            }
        }.padding(.bottom, getSafeArea().bottom * 5)
    }
}

// MARK: - RewardView

struct RewardView: View {
    var title: String
    var subtitle: String

    init(_ prayer: ANPrayer) {
        title = prayer.title
        subtitle = prayer.reward.localized
    }

    init(_ sunnah: ANSunnah) {
        title = sunnah.title
        subtitle = sunnah.reward.localized
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pBody)
                    .multilineTextAlignment(.leading)
                Text(subtitle)
                    .foregroundColor(.success.light)
                    .scaledFont(.pBody, .bold)
                    .multilineTextAlignment(.leading)
            }

            Spacer()
        }
        .padding(.horizontal, .p16)
        .padding(.bottom, .p8)
    }
}
