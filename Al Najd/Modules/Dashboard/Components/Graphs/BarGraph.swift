//
//  SwiftUIView.swift
//
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import SwiftUI

// MARK: - BarGraph

public struct BarGraph: View {
    let days: [DayProgress]
    @Binding var highlightedDay: DayProgress?
    var isPressing: Bool { highlightedDay != nil }
    @State var offset: CGFloat = 0

    public var body: some View {
        HStack(spacing: .p8) {
            ForEach(days) { day in
                buildGraphBars(day: day)
            }
        }
        .animation(.easeInOut, value: highlightedDay)
    }

    @ViewBuilder
    func buildGraphBars(day: DayProgress) -> some View {
        VStack(spacing: .p24) {
            GeometryReader { proxy in
                ZStack {
                    RoundedRectangle(cornerRadius: .r8)
                        .stroke(day.indicator.stroke)
                        .frame(maxHeight: .infinity, alignment: .bottom)

                    RoundedRectangle(cornerRadius: .r8)
                        .fill(day.indicator.fill)
                        .opacity(!isPressing ? 1 : (highlightedDay == day ? 1 : 0.35))
                        .frame(height: (Double(day.count) / Double(day.limit)) * (proxy.size.height))
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .frame(height: 150)
            .shadow(color: day.indicator.shadow, radius: 4, x: 0, y: 0)
            Text(day.day)
                .scaledFont(.pFootnote)
                .foregroundColor(
                    isPressing && highlightedDay == day
                    ? day.indicator.fill
                    : .mono.line)
        }
        .onTapGesture { }
        .onLongPressGesture(
            minimumDuration: .infinity) { isPressing in
                withAnimation(.easeInOut) {
                    highlightedDay = isPressing ? day : nil
                }
        } perform: {
            withAnimation(.easeInOut) {
                highlightedDay = isPressing ? day : nil
            }
        }
    }
}
