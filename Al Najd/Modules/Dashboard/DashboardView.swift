//
//  DashboardView.swift
//
//
//  Created by Ahmed Ramy on 11/02/2022.
//

import Charts
import ComposableArchitecture
import Inject
import SwiftUI

// MARK: - DashboardSegment

struct DashboardSegment: Identifiable, Hashable {
    let id = UUID().uuidString
    let title: String
}

extension DashboardSegment {
    static let faraaid: DashboardSegment = .init(title: L10n.faraaid)
    static let sunnah: DashboardSegment = .init(title: L10n.sunnah)
    static let nawafil: DashboardSegment = .init(title: L10n.nafila)
    static let azkar: DashboardSegment = .init(title: L10n.nafila)

    static let allSegments: [DashboardSegment] = [
        faraaid,
        sunnah,
        nawafil,
        azkar,
    ]
}

// MARK: - DashboardView

public struct DashboardView: View {
    let store: StoreOf<Dashboard>
    @ObservedObject var viewStore: ViewStoreOf<Dashboard>
    @ObserveInjection var inject

    public init(store: StoreOf<Dashboard>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }

    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: .p16) {
                makeCurrentStreakView(viewStore.prayingStreak)
                makeMetricView(title: L10n.faraaid, value: viewStore.totalFaraaidDone).padding(.horizontal)
                HStack {
                    makeMetricView(title: L10n.sunnah, value: viewStore.sunnahsPrayed)
                    makeMetricView(title: L10n.azkar, value: viewStore.azkarDoneCount)
                }.padding(.horizontal)

                RangeAnalysisCardView(progress: viewStore.report)
                    .padding(.horizontal)
                makeChartView(title: L10n.sunnah, viewStore: viewStore)
                    .padding(.horizontal)
                makeFeedbackView(viewStore.feedback)
                    .padding()
            }
            .padding(.vertical)
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
        .background(Color.mono.background)
        .enableInjection()
    }

    @ViewBuilder
    func makeFeedbackView(_ feedback: String) -> some View {
        Text(feedback)
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
                            .stroke(Asset.Colors.Apple.medium.swiftUIColor.gradient, lineWidth: 1))
                    .shadow(color: Asset.Colors.Apple.light.swiftUIColor, radius: 33, x: 0, y: 3))
    }

    @ViewBuilder
    func makeCurrentStreakView(_ streak: String) -> some View {
        VStack {
            Label(L10n.prayingStreak, systemImage: "flame.fill")
                .scaledFont(.pSubheadline)
                .foregroundColor(Asset.Colors.Primary.bluberry.swiftUIColor)
            Text(streak)
                .foregroundColor(Asset.Colors.Primary.solarbeam.swiftUIColor)
                .scaledFont(.pTitle3, .bold)
        }
        .padding()
        .fill()
        .background(
            RoundedRectangle(cornerRadius: .r16)
                .fill()
                .foregroundColor(Asset.Colors.Primary.blackberry.swiftUIColor)
                .shadow(radius: .r8))
        .padding(.horizontal)
    }

    @ViewBuilder
    func makeMetricView(title: String, icon: String? = nil, value: String) -> some View {
        VStack(spacing: .zero) {
            Label(title, systemImage: icon ?? "")
                .scaledFont(.pSubheadline)
                .foregroundColor(Asset.Colors.Primary.bluberry.swiftUIColor)
            Text(value)
                .scaledFont(.pTitle3, .bold)
                .foregroundColor(.mono.offwhite)
        }
        .padding()
        .fill()
        .background(
            RoundedRectangle(cornerRadius: .r16)
                .fill()
                .foregroundColor(Asset.Colors.Primary.blackberry.swiftUIColor)
                .shadow(radius: .r8))
    }

    @ViewBuilder
    func makeChartView(title: String, viewStore: ViewStoreOf<Dashboard>) -> some View {
        VStack {
            Text(title)
                .foregroundColor(Asset.Colors.Blueberry.primary.swiftUIColor)
                .scaledFont(.pHeadline, .bold)
                .fillOnLeading()
            Chart {
                ForEach(viewStore.sunnahPlotData) { data in
                    BarMark(
                        x: .value("Day", data.date.string(withFormat: "d/M")),
                        y: .value("Progress", data.animate ? data.count : 0))
                        .foregroundStyle(Asset.Colors.Blueberry.primary.swiftUIColor.gradient)
                        .cornerRadius(.r8)
                }
            }
            .chartYScale(domain: 0 ... 8)
            .frame(height: 320)
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2, 4]))
                        .foregroundStyle(Asset.Colors.Primary.spaceGrey.swiftUIColor)
                    AxisValueLabel {
                        Text(value.as(String.self) ?? "")
                            .foregroundColor(.mono.offwhite)
                            .scaledFont(.pFootnote, .bold)
                    }
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                        .foregroundStyle(Asset.Colors.Primary.spaceGrey.swiftUIColor)
                    AxisValueLabel {
                        Text(String(format: "%.0f", value.as(Double.self) ?? 0))
                            .foregroundColor(.mono.offwhite)
                            .scaledFont(.pFootnote, .bold)
                    }
                }
            }
        }
        .padding()
        .fill()
        .background(
            RoundedRectangle(cornerRadius: .r16)
                .fill()
                .foregroundColor(Asset.Colors.Primary.blackberry.swiftUIColor)
                .shadow(radius: .r8))
    }
}
