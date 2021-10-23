//
//  OnboardingThirdView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import SwiftUI

struct OnboardingThirdView: View {
  
  @EnvironmentObject var state: OnboardingState
  
  var body: some View {
    ZStack {
      Color("onboarding")
        .ignoresSafeArea()
      
      VStack {
        Text("See how far have you gone".localized)
          .font(.pTitle1)
          .foregroundColor(.secondary3.default)
          .multilineTextAlignment(.center)
          .padding(.top, .p48 + .p48 + .p16)
          .padding(.horizontal, .p40 + .p32)
        
        Image("onboarding3")
          .resizable()
          .aspectRatio(contentMode: .fill)
        
        Group {
          Text("Be your own ".localized)
            .foregroundColor(.secondary3.default)
            .font(.pTitle2)
          
          + Text("Supervisor ".localized)
            .foregroundColor(.primary1.default)
            .font(.pTitle2)
          
          + Text("And take yourself with Allah's (SWT) guidance ".localized)
            .foregroundColor(.secondary3.default)
            .font(.pTitle2)
          
          + Text("To the highest ranks in Jannah".localized)
            .foregroundColor(.primary1.default)
            .font(.pTitle2)
          
        }.multilineTextAlignment(.center)
          .padding(.horizontal, .p24)
      }.padding(.bottom, 144)
    }
  }
}
