//
//  BuffsView.swift
//  The One
//
//  Created by Ahmed Ramy on 17/10/2021.
//

import SwiftUI

struct BuffsView: View {
  @EnvironmentObject var state: HomeState
  
  var body: some View {
    ZStack {
      Color.primary2.default.ignoresSafeArea()
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
      }.padding(.top)
    }
  }
}

struct BuffsView_Previews: PreviewProvider {
  static var previews: some View {
    let state = AppState()
    state.homeState.accumlatedRewards = .faraaid + .sunnah + .nafila
    return BuffsView()
      .environmentObject(state)
  }
}
