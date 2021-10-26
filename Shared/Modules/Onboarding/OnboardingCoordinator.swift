//
//  OnboardingCoordinator.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import Foundation
import SwiftUI

public struct OnboardingCoordinatorView: View {
  @EnvironmentObject var state: OnboardingState
  
  
  public var body: some View {
    if state.onboardingFinished == false {
    SplashView()
        .fullScreenCover(isPresented: $state.startOnboarding, content: {
          OnboardingView()
        })
    } else {
      SplashView()
        .fullScreenCover(isPresented: .constant(state.startOnboarding && state.onboardingFinished), content: { MainCoordinatorView() })
    }
  }
}
