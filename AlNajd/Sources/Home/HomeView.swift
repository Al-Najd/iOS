//
//  HomeView.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import SwiftUI
import Common
import Inject
import Localization
import Entities
import ComposableArchitecture
import Assets
import PrayerDetails
import ReusableUI
import Dashboard
import Utils
import ScalingHeaderScrollView

public struct HomeView: View {
    @ObserveInjection var inject
    let store: StoreOf<Home>

    public init(store: StoreOf<Home>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HeaderView(viewStore: viewStore)
                    prayersSection(viewStore)
                    daySelectorSection(viewStore)
                    makeDuaaView(viewStore)
                    nafilaSection(viewStore)
                    hadeethSection()
                }
                .ignoresSafeArea(edges: .top)
                .fullScreenCover(item: viewStore.binding(\.$selectedPrayer)) { prayerState in
                    IfLetStore(store.scope(state: \.selectedPrayer, action: Home.Action.prayerDetails), then: {
                        PrayerDetailsView(store: $0)
                    })
                }
                .background(Color.mono.background)
                .onAppear { viewStore.send(.onAppear) }
                .enableInjection()
            }
        }
    }
}

private extension HomeView {

    @ViewBuilder
    func nafilaSection(_ viewStore: ViewStoreOf<Home>) -> some View {
        NafilaSliderView(prayers: viewStore.prayers) { _ in print("ok") }
            .padding(.bottom)
    }

    @ViewBuilder
    func hadeethSection() -> some View {
        VStack(alignment: .leading) {
            Text(L10n.ahadeeth)
                .foregroundColor(.mono.offblack)
                .scaledFont(locale: .arabic, .pFootnote, .bold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, .p16)
            HadeethSliderView()
        }
    }



    @ViewBuilder
    func prayersSection(_ viewStore: ViewStoreOf<Home>) -> some View {
        PrayerSliderView(prayers: viewStore.prayers) { viewStore.send(
            .onSelecting($0), animation: .default) }
    }

    @ViewBuilder
    func daySelectorSection(_ viewStore: ViewStoreOf<Home>) -> some View {
        VStack {
            Text(L10n.pickDate)
                .foregroundColor(.mono.offblack)
                .scaledFont(locale: .arabic, .pFootnote, .bold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, .p16)

            DatePicker("", selection: viewStore.binding(\.$date), displayedComponents: .date)
                .datePickerStyle(.graphical)
        }.padding()
    }

	@ViewBuilder
	func makeDuaaView(_ viewStore: ViewStoreOf<Home>) -> some View {
        VStack {
            Text(L10n.todayDuaa)
                .foregroundColor(.mono.offblack)
                .scaledFont(locale: .arabic, .pFootnote, .bold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, .p16)
            Text(viewStore.duaa)
                .scaledFont(.pBody)
                .multilineTextAlignment(.center)
                .foregroundColor(Asset.Colors.Apple.dark.swiftUIColor)
                .padding()
                .fillAndCenter()
                .background(
                    RoundedRectangle(cornerRadius: .r8)
                        .fill()
                        .foregroundColor(Asset.Colors.Apple.light.swiftUIColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: .r8)
                                .stroke(Asset.Colors.Apple.medium.swiftUIColor.gradient, lineWidth: 1)
                        )
                        .shadow(color: Asset.Colors.Apple.light.swiftUIColor, radius: 33, x: 0, y: 3)
                )
        }.padding()
	}
}

struct HeaderView: View {
	let viewStore: ViewStoreOf<Home>

	var body: some View {
		VStack(spacing: .p4) {
			Text(L10n.hud88)
				.foregroundColor(.mono.offwhite)
				.scaledFont(locale: .arabic, .pFootnote, .bold)
				.multilineTextAlignment(.center)

			Label(viewStore.date.formatted(), systemImage: "calendar")
				.foregroundColor(.mono.offwhite)
				.scaledFont(locale: .arabic, .pFootnote)
				.multilineTextAlignment(.center)

			VStack(spacing: .p4) {
				HStack {
					Text(L10n.todaySummary)
						.foregroundColor(.mono.offwhite)
						.scaledFont(.textXSmall)
						.multilineTextAlignment(.center)

					Spacer()

					Text(L10n.todaySummaryNumeric(viewStore.doneTodos.formatted(), viewStore.todosCount.formatted(), viewStore.percentage))
						.foregroundColor(.mono.offwhite)
						.scaledFont(.textXSmall)
						.multilineTextAlignment(.center)
				}

				ProgressBar(
					value: viewStore.binding(\.$percentageValue)
				)
				.frame(height: 8)
				.shadow(color: .shadowBlueperry, radius: 4, x: 0, y: 0)
			}
		}
		.frame(maxWidth: .infinity)
		.padding(.top, getSafeArea().top)
		.padding(.horizontal, .p8)
		.padding(.bottom, .p16)
		.background(
			Color.primaryBlackberry.ignoresSafeArea()
				.background(
					Color.primaryBlackberry
						.frame(height: 1000)
						.offset(y: -500)
				)
		)
	}
}

struct ProgressBar: View {
	@Binding var value: Float
	var color: Color = .mono.offwhite

	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .leading) {
				Group {
					Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
						.opacity(0.3)
						.foregroundColor(color.opacity(0.75))

					Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
						.foregroundColor(color)

				}.cornerRadius(45.0)
			}
		}
	}
}

struct PrayerSliderView: View {
	var prayers: IdentifiedArrayOf<ANPrayer>
	var onTap: (ANPrayer) -> Void

	var body: some View {
		VStack(alignment: .leading, spacing: .p8) {
			Text(L10n.prayers)
				.foregroundColor(.mono.offblack)
				.scaledFont(locale: .arabic, .pFootnote, .bold)
				.multilineTextAlignment(.center)
				.padding(.horizontal, .p16)
			ScrollViewRTL {
				HStack {
					ForEach(prayers) { prayer in
						ZStack {
							prayer.image
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: 175, height: getScreenSize().height * 0.45)
								.overlay(
									Color.mono.offblack.opacity(0.5)
								)
								.contentShape(RoundedRectangle(cornerRadius: .r16))
							VStack {
								Spacer()
								Text(prayer.title)
									.foregroundColor(.mono.offwhite)
									.scaledFont(.pFootnote)
									.multilineTextAlignment(.center)
									.padding(.bottom, .p4)
							}.padding(.horizontal, .p4)
						}
						.cornerRadius(.r16)
						.clipped()
						.onTapGesture {
							onTap(prayer)
						}
					}
				}
				.padding(.horizontal, .p16)
			}
		}
	}
}

struct NafilaSliderView: View {
	var prayers: IdentifiedArrayOf<ANPrayer>
	var onTap: (ANPrayer) -> Void

	var body: some View {
		VStack(alignment: .leading, spacing: .p8) {
			Text(L10n.nafila)
				.foregroundColor(.mono.offblack)
				.scaledFont(locale: .arabic, .pFootnote, .bold)
				.multilineTextAlignment(.center)
				.padding(.horizontal, .p16)
			ScrollViewRTL {
				HStack {
					ForEach(prayers) { prayer in
						ZStack {
							Asset.Prayers.Images.duhaImage.swiftUIImage
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: getScreenSize().width * 0.8, height: getScreenSize().height * 0.15)
								.overlay(
									Color.mono.offblack.opacity(0.5)
								)
								.contentShape(RoundedRectangle(cornerRadius: .r16))
							VStack {
								Spacer()
								Text(prayer.title)
									.foregroundColor(.mono.offwhite)
									.scaledFont(.pFootnote)
									.multilineTextAlignment(.center)
									.padding(.bottom, .p4)
							}.padding(.horizontal, .p4)
						}
						.cornerRadius(.r16)
						.clipped()
						.onTapGesture {
							onTap(prayer)
						}
					}
				}
				.padding(.horizontal, .p16)
			}
		}
	}
}

struct HadeethSliderView: View {
	var ahadeeth: [String] = [
		L10n.hadeeth1,
		L10n.hadeeth2
	]

	var body: some View {
		Text(ahadeeth.randomElement() ?? ahadeeth[0])
			.scaledFont(.pBody)
			.multilineTextAlignment(.center)
			.foregroundColor(Asset.Colors.Apple.dark.swiftUIColor)
			.padding()
			.frame(width: getScreenSize().width * 0.95)
			.background(
				RoundedRectangle(cornerRadius: .r8)
					.fill()
					.foregroundColor(Asset.Colors.Apple.light.swiftUIColor)
					.overlay(
						RoundedRectangle(cornerRadius: .r8)
							.stroke(Asset.Colors.Apple.medium.swiftUIColor.gradient, lineWidth: 1)
					)
					.shadow(color: Asset.Colors.Apple.light.swiftUIColor, radius: 33, x: 0, y: 3)
			)
			.padding([.leading, .trailing, .bottom])
	}
}
