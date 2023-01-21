//
//  SwiftUIView 3.swift
//
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import Common
import DesignSystem
import Inject
import SwiftUI

public struct RangeProgress: Identifiable, Equatable {
    public let id = UUID().uuidString
    public let title: String
    public let reports: [DayProgress]
    public let hasEnoughData: Bool
    public let progressColor: BrandColor
    public let insight: Insight?
    public let score: Int

    public var isImproving: Bool?

    public init(
        title: String,
        reports: [DayProgress],
        isImproving: Bool? = nil,
        insight: Insight? = nil,
        score: Int = 0
    ) {
        self.title = title
        self.reports = reports
        self.isImproving = isImproving
        progressColor = isImproving ?? true ? Color.success : Color.danger
        self.insight = insight
        hasEnoughData = !reports.isEmpty
        self.score = score
    }

    public static func == (lhs: RangeProgress, rhs: RangeProgress) -> Bool {
        lhs.id == rhs.id
    }

    func changeImprovement(to didImprove: Bool) -> RangeProgress {
        .init(title: title, reports: reports, isImproving: didImprove, insight: insight)
    }
}

public extension RangeProgress {
    static let mock: [RangeProgress] = [
        .init(
            title: "Faraaid",
            reports: DayProgress.mock,
            isImproving: false,
            insight: .init(indicator: .danger, details: "Al Faraaid are very important, make sure you don't miss them intentionally and ask for help from Allah, you got this!")
        ),
        .init(
            title: "Sunnah",
            reports: DayProgress.mock,
            isImproving: true,
            insight: .init(
                indicator: .encourage,
                details: "You did great with Sunnah last week, let's max out this week's Sunnah!"
            )
        ),
        .init(
            title: "Nafila",
            reports: DayProgress.mock,
            isImproving: false,
            insight: .init(
                indicator: .praise,
                details: "You did Wonderful in Nafila!, I mean, wow! off the charts!, are we speaking to a 'Wali' now or what? haha, great work champ!"
            )
        ),
    ]
}

public struct DayProgress: Identifiable, Equatable {
    public var id = UUID().uuidString
    let count: Int
    let day: String
    let limit: Int
    let indicator: Indicator

    static let mock: [DayProgress] = [
        .init(count: 5, day: "S", limit: 5, indicator: .good),
        .init(count: 0, day: "S", limit: 5, indicator: .bad),
        .init(count: 1, day: "M", limit: 5, indicator: .bad),
        .init(count: 2, day: "T", limit: 5, indicator: .moderate),
        .init(count: 4, day: "W", limit: 5, indicator: .good),
        .init(count: 3, day: "T", limit: 5, indicator: .moderate),
        .init(count: 5, day: "F", limit: 5, indicator: .good),
    ]

    public struct Indicator {
        let color: BrandColor

        static let good: Indicator = .init(color: Color.success)
        static let moderate: Indicator = .init(color: Color.warning)
        static let bad: Indicator = .init(color: Color.danger)
    }

    public static func == (lhs: DayProgress, rhs: DayProgress) -> Bool {
        lhs.id == rhs.id
    }
}

public struct RangeAnalysisCardView: View {
    @ObserveInjection var inject

    @State var highlightedDay: DayProgress?
    let progress: RangeProgress

    public var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    VStack(alignment: .leading, spacing: .p8) {
                        Text(progress.title.localized)
                            .scaledFont(.pTitle1, .bold)
                            .foregroundColor(.mono.offblack)

                        if progress.hasEnoughData {
                            if let highlightedDay = highlightedDay {
                                Text(
                                    "n out of n".localized(
                                        arguments: highlightedDay.count, highlightedDay.limit
                                    )
                                )
                                .scaledFont(.pHeadline, .bold)
                                .foregroundColor(highlightedDay.indicator.color.light)
                                .padding(.vertical, .p4)
                                .padding(.horizontal, .p8)
                                .background(
                                    RoundedRectangle(cornerRadius: .r16)
                                        .fill(highlightedDay.indicator.color.dark)
                                        .shadow(color: highlightedDay.indicator.color.default, radius: .r4)
                                )
                            } else {
                                Text("Last n Days".localized(arguments: progress.reports.count))
                                    .scaledFont(.pHeadline, .bold)
                                    .foregroundColor(.mono.offblack.opacity(0.5))
                            }
                        }
                    }

                    Spacer()

                    if progress.hasEnoughData, let isImproving = progress.isImproving {
                        Image(systemName: "arrow.up.forward")
                            .scaledFont(.pTitle3, .bold)
                            .padding(.p8)
                            .foregroundColor(progress.progressColor.default)
                            .background(
                                Circle()
                                    .fill(progress.progressColor.background)
                                    .shadow(color: progress.progressColor.background, radius: 5, x: 0, y: 0)
                            )
                            .rotationEffect(.degrees(isImproving ? 0 : 90))
                    }
                }

                if progress.hasEnoughData {
                    BarGraph(
                        days: progress.reports,
                        highlightedDay: $highlightedDay
                    )
                } else {
                    VStack {
                        Image(systemName: "questionmark.circle.fill")
                        Text("Unfortunately there is not enough data to analyze this week".localized)
                    }
                    .scaledFont(.pHeadline, .bold)
                    .padding(.p8)
                    .foregroundColor(.mono.offblack.opacity(0.5))
                    .multilineTextAlignment(.center)
                }
            }
            .padding(.p16)
            .background(
                RoundedRectangle(cornerRadius: .r16)
                    .fill(Color.mono.offwhite)
                    .shadow(
                        color: .black.opacity(0.25),
                        radius: 2,
                        x: 0, y: 0
                    )
            )

            if let insight = progress.insight {
                InsightCardView(insight: insight)
            }
        }.enableInjection()
    }
}

struct SwiftUIView_3_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(store: .mock)
    }
}
