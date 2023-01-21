//
//  SwiftUIView.swift
//
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import SwiftUI

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
                        .stroke(day.indicator.color.default)
                        .frame(maxHeight: .infinity, alignment: .bottom)

                    RoundedRectangle(cornerRadius: .r8)
                        .fill(day.indicator.color.default)
                        .opacity(!isPressing ? 1 : (highlightedDay == day ? 1 : 0.35))
                        .frame(height: (Double(day.count) / Double(day.limit)) * (proxy.size.height))
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .frame(height: 150)
            Text(day.day)
                .scaledFont(.pFootnote)
                .foregroundColor(
                    isPressing && highlightedDay == day
                        ? day.indicator.color.default
                        : .mono.label
                )
        }
        .onTapGesture {}
        .onLongPressGesture(
            minimumDuration: .infinity
        ) { isPressing in
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(store: .mock)
            .stay(.dark)
    }
}
