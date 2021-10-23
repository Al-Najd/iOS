//
//  OnboardingFirstView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import SwiftUI

struct OnboardingFirstView: View {
  
  @EnvironmentObject var state: OnboardingState
  
  var body: some View {
    ZStack {
      Color("onboarding")
        .ignoresSafeArea()
      
      VStack {
        Text("Welcome To The Najd".localized)
          .font(.pTitle1)
          .foregroundColor(.secondary3.default)
          .multilineTextAlignment(.center)
          .padding(.top, .p48 + .p48 + .p16)
          .padding(.horizontal, .p40 + .p32)
        
        Image("onboarding1")
          .resizable()
          .aspectRatio(contentMode: .fill)
        
        Group {
          Text("We Can ".localized)
            .foregroundColor(.secondary3.default)
            .font(.pTitle2)
          
          + Text("Help you ".localized)
            .foregroundColor(.primary1.default)
            .font(.pTitle2)
          
          + Text("To be a better version of ".localized)
            .foregroundColor(.secondary3.default)
            .font(.pTitle2)
          
          + Text("Yourself".localized)
            .foregroundColor(.primary1.default)
            .font(.pTitle2)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, .p24)
      }.padding(.bottom, 144)
    }
  }
}
