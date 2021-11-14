//
//  SplashView.swift
//  The One
//
//  Created by Ahmed Ramy on 22/10/2021.
//

import SwiftUI

struct SplashView: View {
  @EnvironmentObject var state: OnboardingState
  
  var body: some View {
    ZStack {
      Color("splash")
        .ignoresSafeArea()
      
      Image("splash")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .ignoresSafeArea()
        .scaleEffect(state.scaleValue)
        .opacity(state.bgFadeValue)
      
      VStack {
        Text("Welcome To The Najd".localized)
          .font(.pLargeTitle)
          .foregroundColor(.secondary3.default)
          .multilineTextAlignment(.center)
          .padding(.top, .p48 + .p48)
          .padding(.horizontal, .p40 + .p32)
          .opacity(state.textFadeValue)
          .offset(y: state.t1YOffset)
        
        Text("Your companion to a better Akhra".localized)
          .font(.pTitle2)
          .foregroundColor(.primary1.default)
          .multilineTextAlignment(.center)
          .padding(.top)
          .opacity(state.textFadeValue)
          .offset(y: state.t2YOffset)
        
        Spacer()
      }
    }
    .opacity(state.splashOpacity)
    .onAppear {
      setupInitialAnimations(then: {
        withAnimation(.easeInOut(duration: 1)) {
          state.splashOpacity = 0
          let didSeeOnboarding = false // TODO: - Fetch from Cache
          if didSeeOnboarding {
            state.showMainApp = true
          } else {
            state.startOnboarding = true
          }
        }
      })
    }
  }
  
  func setupInitialAnimations(then nextAction: @escaping VoidCallback) {
    MusicService.main.start(track: .splash, repeats: true)
    
    withAnimation(.spring().speed(0.25)) {
      state.scaleValue = 1.2
      state.bgFadeValue = 1
    }
    
    withAnimation(.easeInOut(duration: 2.5)) {
      state.textFadeValue = 1
      state.t1YOffset = 0
      
    }
    
    withAnimation(.easeInOut(duration: 2.85)) {
      state.t2YOffset = 0
    }
    
    after(seconds: 2.85) {
      withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
        state.t1YOffset = 30
      }
      
      withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
        state.t2YOffset = 25
      }
      
      after(seconds: 5) {
        MusicService.main.start(effect: .splashEnd)
        withAnimation(.easeIn(duration: 3)) {
          state.t1YOffset = 1250
          state.t2YOffset = 1600
          state.scaleValue = 275
          state.bgFadeValue = 0
        }
        
        withAnimation(.easeInOut(duration: 1.5)) {
          state.textFadeValue = 0
        }
      }
      
      after(seconds: 7) {
        withAnimation(.easeInOut(duration: 1)) {
          nextAction()
        }
      }
    }
  }
}
