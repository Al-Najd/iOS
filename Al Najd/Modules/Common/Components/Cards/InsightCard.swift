//
//  InsightCard.swift
//
//
//  Created by Ahmed Ramy on 12/02/2022.
//


import SwiftUI

// MARK: - Insight

public struct Insight {
    public let indicator: Indicator
    public let details: String

    public init(indicator: Insight.Indicator, details: String) {
        self.indicator = indicator
        self.details = details
    }
}

// MARK: - InsightCardView

public struct InsightCardView: View {
    public let insight: Insight

    public init(insight: Insight) {
        self.insight = insight
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .p16) {
            Label {
                Text(insight.indicator.title)
            } icon: {
                Image(systemName: insight.indicator.icon)
            }
            .scaledFont(.pHeadline, .bold)
            .foregroundColor(insight.indicator.color.default)

            Text(insight.details)
                .scaledFont(.pBody, .bold)
                .foregroundColor(.mono.offblack)
        }
        .frame(maxWidth: .infinity)
        .padding(.p16)
        .background(
            RoundedRectangle(cornerRadius: .r16)
                .fill(Color.mono.offwhite)
                .shadow(
                    color: .black.opacity(0.25),
                    radius: 2,
                    x: 0, y: 0))
    }
}

// MARK: - Insight.Indicator

public extension Insight {
    struct Indicator: Identifiable, Equatable {
        public let id = UUID().uuidString
        let color: BrandColor
        let icon: String
        let title: String

        public static let praise: Indicator = .init(
            color: Color.success,
            icon: "hands.clap.fill",
            title: "Good Job!".localized)

        public static func == (lhs: Insight.Indicator, rhs: Insight.Indicator) -> Bool {
            lhs.id == rhs.id
        }

        public static let encourage: Indicator = .init(
            color: Color.warning,
            icon: "bolt.heart.fill",
            title: "Keep it up, you can do it!".localized)

        public static let tipOfTheDay: Indicator = .init(
            color: Color.success,
            icon: "star.fill",
            title: "Tip of the day".localized)

        public static let danger: Indicator = .init(
            color: Color.danger,
            icon: "flame.circle.fill",
            title: "Heads up!".localized)
    }
}
