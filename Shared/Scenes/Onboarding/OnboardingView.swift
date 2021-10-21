//
//  OnboardingView.swift
//  The One (iOS)
//
//  Created by Ahmed Ramy on 21/10/2021.
//

import SwiftUI

struct OnboardingView: View {

  @State private var scaleValue: CGFloat = 3.0
  @State private var bgFadeValue: CGFloat = 0
  @State private var textFadeValue: CGFloat = 0
  @State private var t1YOffset: CGFloat = 200
  @State private var t2YOffset: CGFloat = 200
  var body: some View {
    ZStack {
      Color("splash")
        .ignoresSafeArea()
      
      Image("splash")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .ignoresSafeArea()
        .scaleEffect(scaleValue)
        .opacity(bgFadeValue)
        
      VStack {
        Text("Welcome To The Najd")
          .font(.pLargeTitle)
          .foregroundColor(.secondary3.default)
          .multilineTextAlignment(.center)
          .padding(.top, .p48 + .p48)
          .padding(.horizontal, .p40 + .p32)
          .opacity(textFadeValue)
          .offset(y: t1YOffset)
        
        Text("Your companion to a better Akhra")
          .font(.pTitle2)
          .foregroundColor(.primary1.default)
          .multilineTextAlignment(.center)
          .padding(.top)
          .opacity(textFadeValue)
          .offset(y: t2YOffset)
        
        Spacer()
      }
    }.onAppear {
      MusicService.main.start(track: .splash)
      
      withAnimation(.spring().speed(0.25)) {
        scaleValue = 1.2
        bgFadeValue = 1
      }
      
      withAnimation(.easeInOut(duration: 2.5)) {
        textFadeValue = 1
        t1YOffset = 0
        t2YOffset = 0
      }
      
      after(seconds: 2) {
        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
          t1YOffset = 30
        }
        
        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
          t2YOffset = 25
        }
        
        after(seconds: 3) {
          MusicService.main.start(effect: .splashEnd)
          withAnimation(.easeIn(duration: 3)) {
            t1YOffset = 1100
            t2YOffset = 1100
            scaleValue = 275
            bgFadeValue = 0
          }
          
          withAnimation(.easeInOut(duration: 1.5)) {
            textFadeValue = 0
          }
        }
      }
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
