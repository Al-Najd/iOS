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
import Utils
import Common
import DesignSystem
import ComposableArchitecture
import ReusableUI
import Entities
import Inject

struct PlaygroundView: View {
  @ObserveInjection var inject

  let image: ImageAsset = Asset
    .Prayers
    .Faraaid
    .maghribImage

  @State var progress: Double = 0.25
  let store = StoreOf<Home>.init(initialState: .init(), reducer: Home())

  var body: some View {
    WithViewStore(store) { viewStore in
      PrayerSliderView(prayers: viewStore.prayers) {_ in 
        
      }
      .onAppear { viewStore.send(.onAppear) }
      .enableInjection()
    }
  }
}

struct PrayerSliderView: View {
  var prayers: IdentifiedArrayOf<ANPrayer>
  var onTap: (ANPrayer) -> Void

  private let screenSize = getScreenSize()

  var body: some View {
    VStack(alignment: .leading, spacing: .p8) {
      Text(L10n.prayers)
        .foregroundColor(.mono.offblack)
        .scaledFont(locale: .arabic, .pFootnote, .bold)
        .multilineTextAlignment(.center)
        .padding(.horizontal, .p16)
      ScrollViewRTL {
        HStack(spacing: .p32) {
          ForEach(prayers) { prayer in
            GeometryReader { geometry in
              PrayerCardView(prayer: prayer)
                .rotation3DEffect(
                  .degrees(((.p32 + geometry.frame(in: .local).width) / 2 - geometry.frame(in: .global).minX) / (30.0)),
                  axis: (x: 15, y: 45, z: 0)
                )
                .onTapGesture {
                  onTap(prayer)
                }
            }
            .frame(width: screenSize.width * 0.45, height: screenSize.height * 0.33)
          }
        }
        .padding(.horizontal, .p16)
      }.onAppear {
        print(screenSize.height)
      }
    }.padding()
  }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
      PlaygroundView()
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

