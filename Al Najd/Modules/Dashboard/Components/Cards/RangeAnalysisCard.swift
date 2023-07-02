//
//  SwiftUIView 3.swift
//
//
//  Created by Ahmed Ramy on 12/02/2022.
//



import Inject
import SwiftUI

// MARK: - RangeProgress

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
        score: Int = 0) {
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

// MARK: - RangeAnalysisCardView

public struct RangeAnalysisCardView: View {
    @ObserveInjection var inject

    @State var highlightedDay: DayProgress?
    let progress: RangeProgress

    public var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: .p16) {
                HStack {
                    VStack(alignment: .leading, spacing: .p8) {
                        Text(progress.title.localized)
                            .scaledFont(.pTitle1, .bold)
                            .foregroundColor(.primaryBluberry)

                        if progress.hasEnoughData {
                            if let highlightedDay = highlightedDay {
                                Text(
                                    "n out of n".localized(
                                        arguments: highlightedDay.count, highlightedDay.limit
                                    ))
                                    .scaledFont(.pHeadline, .bold)
                                    .foregroundColor(highlightedDay.indicator.fill)
                                    .padding(.vertical, .p4)
                                    .padding(.horizontal, .p8)
                                    .background(
                                        RoundedRectangle(cornerRadius: .r16)
                                            .fill(highlightedDay.indicator.stroke)
                                            .shadow(color: highlightedDay.indicator.shadow, radius: .r4))
                            } else {
                                Text("Last n Days".localized(arguments: progress.reports.count))
                                    .scaledFont(.pHeadline, .bold)
                                    .foregroundColor(.mono.line)
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
                                    .shadow(color: progress.progressColor.background, radius: 5, x: 0, y: 0))
                            .rotationEffect(.degrees(isImproving ? 0 : 90))
                    }
                }

                if progress.hasEnoughData {
                    BarGraph(
                        days: progress.reports,
                        highlightedDay: $highlightedDay)
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
                    .fill(Color.primaryBlackberry)
                    .shadow(
                        color: .black.opacity(0.25),
                        radius: 2,
                        x: 0, y: 0))

            if let insight = progress.insight {
                InsightCardView(insight: insight)
            }
        }.enableInjection()
    }
}
