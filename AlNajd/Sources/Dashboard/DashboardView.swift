//
//  DashboardView.swift
//  
//
//  Created by Ahmed Ramy on 11/02/2022.
//

import SwiftUI
import DesignSystem
import Utils
import PreviewableView
import ComposableArchitecture
import Inject
import ReusableUI
import Localization
import Assets
import Charts

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
        azkar
    ]
}

struct NafilaAnalyticsData: Identifiable {
    let id: UUID = .init()
    let date: Date
    let count: Int
    var animate: Bool = false
    
    static let dummy: [NafilaAnalyticsData] = {
        (-6...0).map {
            .init(
                date: Date.now.startOfDay.adding(.day, value: $0),
                count: Int.random(in: 0...8)
            )
        }
    }()
}

public struct DashboardView: View {
    let store: Store<DashboardState, DashboardAction>
    @ObserveInjection var inject
    @State var plotData = NafilaAnalyticsData.dummy
    
    public init(store: Store<DashboardState, DashboardAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView(.vertical) {
                VStack(spacing: .p16) {
                    makeCurrentStreakView()
                    HStack {
                        makeMetricView(title: L10n.faraaid, value: L10n.prayers)
                        makeMetricView(title: L10n.azkar, value: L10n.azkarAlSabah)
                    }.padding(.horizontal)
                    
                    makeNafilaChartView()
                        .padding(.horizontal)
                    makeFeedbackView()
                        .padding(.horizontal)
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .background(
                Color.mono.background
            )
            .enableInjection()
        }
    }
    
    @ViewBuilder
    func makeFeedbackView() -> some View {
        Text("انت شغال كويس, عاش جدا!\nكمل 🔥")
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
    }
    
    @ViewBuilder
    func makeCurrentStreakView() -> some View {
        VStack {
            Label("Current Streak", systemImage: "flame.fill")
                .scaledFont(.pSubheadline)
                .foregroundColor(Asset.Colors.Primary.bluberry.swiftUIColor)
            Text("32 Day")
                .foregroundColor(Asset.Colors.Primary.solarbeam.swiftUIColor)
                .scaledFont(.pTitle3, .bold)
        }
        .padding()
        .fill()
        .background(
            RoundedRectangle(cornerRadius: .r16)
                .fill()
                .foregroundColor(Asset.Colors.Primary.blackberry.swiftUIColor)
                .shadow(radius: .r8)
        )
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
                .shadow(radius: .r8)
        )
    }
    
    @ViewBuilder
    func makeNafilaChartView() -> some View {
        VStack {
            Text(L10n.nafila)
                .foregroundColor(Asset.Colors.Blueberry.primary.swiftUIColor)
                .scaledFont(.pHeadline, .bold)
                .fillOnLeading()
            Chart {
                ForEach(plotData) { data in
                    BarMark(
                        x: .value("Day", data.date.string(withFormat: "d/M")),
                        y: .value("Progress", data.animate ? data.count : 0)
                    )
                    .foregroundStyle(Asset.Colors.Blueberry.primary.swiftUIColor.gradient)
                    .cornerRadius(.r8)
                }
            }
            .chartYScale(domain: 0...(8))
            .frame(height: 320)
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2, 4]))
                        .foregroundStyle(Asset.Colors.Primary.spaceGrey.swiftUIColor)
                    AxisValueLabel() {
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
                    AxisValueLabel() {
                        Text(String(format: "%.0f", value.as(Double.self) ?? 0))
                            .foregroundColor(.mono.offwhite)
                            .scaledFont(.pFootnote, .bold)
                    }
                }
            }
            .onAppear {
                plotData.enumerated().forEach { index, _ in
                    withAnimation(
                        .easeInOut(duration: 0.8 + (Double(index) * 0.05))
                        .delay(Double(index) * 0.05)
                    ) {
                        plotData[index].animate = true
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
                .shadow(radius: .r8)
        )
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            store: .mock
        ).background(
            Color.mono.background.ignoresSafeArea()
        )
    }
}
