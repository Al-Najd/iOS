//
//  OnboardingSecondView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import SwiftUI

struct OnboardingSecondView: View {
  
  @EnvironmentObject var state: OnboardingState
  
  var body: some View {
    ZStack {
      Color("onboarding")
        .ignoresSafeArea()
      
      VStack {
        Text("Make Salat Easy and Fun".localized)
          .font(.pTitle1)
          .foregroundColor(.secondary3.default)
          .multilineTextAlignment(.center)
          .padding(.top, .p48 + .p48 + .p16)
          .padding(.horizontal, .p40 + .p32)
        
        Image("onboarding2")
          .resizable()
          .aspectRatio(contentMode: .fill)
        
        Group {
          Text("By learning about the benefits of".localized)
            .foregroundColor(.secondary3.default)
            .font(.pTitle2)
          
          + Text("Salat".localized)
            .foregroundColor(.primary1.default)
            .font(.pTitle2)
          
          + Text("The Faard that was too hard".localized)
            .foregroundColor(.secondary3.default)
            .font(.pTitle2)
          
          + Text("Is now calling you to pray it and Sunnah and Nafila!".localized)
            .foregroundColor(.primary1.default)
            .font(.pTitle2)
          
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, .p24)
        
      }.padding(.bottom, 144)
    }
  }
}
