//
//  BuffsView.swift
//  The One
//
//  Created by Ahmed Ramy on 17/10/2021.
//

import SwiftUI

struct BuffsView: View {
  @EnvironmentObject var state: AppState
  
  var body: some View {
    ZStack {
      Color.primary.default.ignoresSafeArea()
      ScrollView {
      VStack {
        ForEach(state.accumlatedRewards) { deed in
          VStack {
            Text(deed.title)
              .multilineTextAlignment(.center)
              .font(.pTitle2)
              .foregroundColor(.mono.offwhite)
              .padding(.bottom, .p4)
            Text( deed.reward.title)
              .multilineTextAlignment(.center)
              .font(.pTitle3)
              .foregroundColor(.success.light)
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
              .foregroundColor(.primary.dark
                              )
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
    state.accumlatedRewards = .faraaid + .sunnah + .nafila
    return BuffsView()
      .environmentObject(state)
  }
}
