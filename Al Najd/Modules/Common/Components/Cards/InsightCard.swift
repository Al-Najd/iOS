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
            .foregroundColor(insight.indicator.fill)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)

            Text(insight.details)
                .scaledFont(.pBody, .bold)
                .foregroundColor(.mono.line)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.p16)
        .background(
            RoundedRectangle(cornerRadius: .r16)
                .fill(Color.primaryBlackberry)
                .shadow(
                    color: insight.indicator.shadow,
                    radius: 2,
                    x: 0, y: 0))
    }
}

// MARK: - Insight.Indicator

public extension Insight {
    struct Indicator: Identifiable, Equatable {
        public let id = UUID().uuidString
        let fill: Color
        let shadow: Color
        let icon: String
        let title: String

        public static let praise: Indicator = .init(
            fill: .primaryBluberry,
            shadow: .shadowBlueperry,
            icon: "hands.clap.fill",
            title: L10n.dashboardIndicatorPraiseMessage.localized)

        public static func == (lhs: Insight.Indicator, rhs: Insight.Indicator) -> Bool {
            lhs.id == rhs.id
        }

        public static let encourage: Indicator = .init(
            fill: .tangerinePrimary,
            shadow: .shadowTangerine,
            icon: "bolt.heart.fill",
            title: L10n.dashboardIndicatorEncourageMessage.localized)

        public static let danger: Indicator = .init(
            fill: .cherryPrimary,
            shadow: .shadowCherry,
            icon: "flame.circle.fill",
            title: L10n.dashboardIndicatorWarningMessage.localized)
    }
}
