//
//  OnboardingView.swift
//  The One (iOS)
//
//  Created by Ahmed Ramy on 21/10/2021.
//

import SwiftUI
import Combine

class OnboardingState: ObservableObject {
  // MARK: - Splash
  @Published var scaleValue: CGFloat = 3.0
  @Published var bgFadeValue: CGFloat = 1
  @Published var textFadeValue: CGFloat = 1
  @Published var t1YOffset: CGFloat = 200
  @Published var t2YOffset: CGFloat = 200
  @Published var startOnboarding: Bool = false
  @Published var splashOpacity: CGFloat = 1
  
  // MARK: - Onboarding
  @Published var offset: Int = 0
  @Published(key: "onboardingFinished") var onboardingFinished: Bool = false
  @Published var showMainApp: Bool = false
}

struct OnboardingView: View {
  @EnvironmentObject var state: OnboardingState
  
  var body: some View {
    ZStack {
      Color("onboarding")
        .ignoresSafeArea()
      TabView(selection: $state.offset.animation()) {
        OnboardingFirstView()
          .tag(0)
        OnboardingSecondView()
          .tag(1)
        OnboardingThirdView()
          .tag(2)
        OnboardingForthView()
          .tag(3)
      }
      .edgesIgnoringSafeArea(.vertical)
      .tabViewStyle(.page(indexDisplayMode: .never))
      
      
        VStack {
          HStack {
            Button(
              action: {
                withAnimation {
                  state.onboardingFinished = true
                }
              },
              label: {
                Text("Skip".localized)
                  .font(.displaySmall)
                  .foregroundColor(.primary1.default)
                  .frame(maxWidth: .infinity)
              }
            )
              .frame(width: 100, height: 20)
              .padding(.vertical, .p4)
              .background(
                RoundedRectangle(cornerRadius: .r8)
                  .stroke(lineWidth: 2)
                  .foregroundColor(.primary1.default)
              )
              .colorScheme(.light)
            
            Spacer()
            
            Button(
              action: {
                withAnimation {
                  state.offset = (state.offset + 1).clamped(to: 0...3)
                }
              },
              label: {
                Text("Next".localized)
                  .font(.displaySmall)
                  .foregroundColor(.mono.offwhite)
                  .frame(maxWidth: .infinity)
              }
            )
              .frame(width: 100, height: 20)
              .padding(.vertical, .p4)
              .background(Color.primary1.default)
              .cornerRadius(.p8)
              .colorScheme(.light)
          }
          .padding(.top, .p32)
          .padding(.horizontal)
          Spacer()
          if !(state.offset < 3) {
            PButton(action: {
              withAnimation {
                state.startOnboarding = false
                state.onboardingFinished = true
                state.showMainApp = true
              }
            }, title: "Get Started".localized)
              .padding(.p24)
              .colorScheme(.light)
          }
      }
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
      .environmentObject(app.state.onboardingState)
  }
}
