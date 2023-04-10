//
//  PrayerCardView.swift
//  PlaygroundPreview
//
//  Created by Ahmed Ramy on 10/04/2023.
//

import SwiftUI
import Assets
import Home
import Localization

struct PrayerCardView: View {
  let image: ImageAsset = Asset
    .Prayers
    .Faraaid
    .maghribImage

  @State var progress: Double = 0.25

  var body: some View {
    HeaderView()
  }
}

struct HeaderView: View {
  var body: some View {
    VStack {
      VStack(spacing: .p4) {
        Text(L10n.hud88)
          .foregroundColor(.mono.offwhite)
          .scaledFont(locale: .arabic, .pFootnote, .bold)
          .multilineTextAlignment(.center)

        Label("12/12/2012", systemImage: "calendar")
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
          }

          ProgressBar(
            value: .constant(0.75)
          )
          .frame(height: 8)
          .shadow(color: .shadowBlueperry, radius: 4, x: 0, y: 0)
          .padding(.bottom, .p16)
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.top, getSafeArea().top)
      .padding(.horizontal, .p8)
      .padding(.bottom, .p16)
      .background(
        ZStack {
          Color
            .primaryBlackberry
            .ignoresSafeArea()
            .background(
              Color.primaryBlackberry
                .frame(height: 1000)
                .offset(y: -500)
            )
            .offset(y: -100)

          Asset
            .Background
            .headerMini
            .swiftUIImage
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
        }
      )

      Spacer()
    }
  }
}

struct PrayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerCardView()
    }
}

struct ProgressBar: View {
  @Binding var value: Double
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

