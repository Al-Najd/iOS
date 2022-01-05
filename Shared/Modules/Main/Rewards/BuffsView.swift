//
//  BuffsView.swift
//  The One
//
//  Created by Ahmed Ramy on 17/10/2021.
//

import SwiftUI

struct BuffsView: View {
  @EnvironmentObject var state: PrayersState
  
  var body: some View {
    ZStack {
      Color.mono.offwhite.ignoresSafeArea()
      buildContentView()
    }
  }
  
  @ViewBuilder func buildContentView() -> some View {
    if !state.accumlatedRewards.isEmpty {
      ScrollView {
      VStack {
        ForEach(state.accumlatedRewards) { deed in
          VStack {
            Text(deed.title)
              .multilineTextAlignment(.center)
              .font(.pTitle2)
              .foregroundColor(.mono.ash)
              .padding(.bottom, .p4)
            Text( deed.reward.title)
              .multilineTextAlignment(.center)
              .font(.pTitle3)
              .foregroundColor(.success.dark)
          }
          .frame(
            maxWidth: .infinity,
            alignment: .center
          )
          .padding()
          .background(
            RoundedRectangle(
              cornerRadius: .r16
            )
              .foregroundColor(.primary2.dark)
          )
          .padding()
        }
      }
        
        Spacer()
      }
    } else {
      Text("A day full of blessings is awaiting your deeds!".localized)
        .multilineTextAlignment(.center)
        .font(.pLargeTitle)
        .foregroundColor(.mono.offblack)
        .padding(.bottom, .p8)
    }
  }
}

struct BuffsView_Previews: PreviewProvider {
  static var previews: some View {
    let state = PrayersState()
    state.accumlatedRewards = .faraaid + .sunnah + .nafila
    return BuffsView()
      .environmentObject(state)
  }
}
