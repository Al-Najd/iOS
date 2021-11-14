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
    SplashView()
      .fullScreenCover(isPresented: $state.startOnboarding, content: { OnboardingView() })
      .fullScreenCover(isPresented: $state.showMainApp, content: { MainCoordinatorView() })
  }
}
