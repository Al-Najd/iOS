//
//  OnboardingForthView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import SwiftUI

struct OnboardingForthView: View {
  
  @EnvironmentObject var state: OnboardingState
  
  var body: some View {
    ZStack {
      Color("onboarding")
        .ignoresSafeArea()
      
      VStack {
        Text("Join a supportive community of fellow Muslims!".localized)
          .font(.pTitle1)
          .foregroundColor(.secondary3.default)
          .multilineTextAlignment(.center)
          .padding(.top, .p48 + .p48 + .p16)
          .padding(.horizontal, .p40 + .p32)
        
        Image("onboarding4")
          .resizable()
          .aspectRatio(contentMode: .fill)
        
        Group {
          Text("Choose ".localized)
            .foregroundColor(.secondary3.default)
            .font(.pTitle2)
          
          + Text("the pal ".localized)
            .foregroundColor(.primary1.default)
            .font(.pTitle2)
          
          + Text("before the ".localized)
            .foregroundColor(.secondary3.default)
            .font(.pTitle2)
          
          + Text("Road".localized)
            .foregroundColor(.primary1.default)
            .font(.pTitle2)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, .p24)
      }
      .padding(.bottom, 144)
    }
    .frame(maxWidth: .infinity)
    .padding(.p24)
  }
}
