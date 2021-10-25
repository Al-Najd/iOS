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
      .tabViewStyle(.page)
      .indexViewStyle(.page(backgroundDisplayMode: state.offset < 3 ? .always : .interactive))
      
      if !(state.offset < 3) {
        VStack {
          Spacer()
          PButton(action: { state.onboardingFinished = true }, title: "Get Started".localized)
            .padding(.p24)
            .colorScheme(.light)
        }
      }
    }.fullScreenCover(isPresented: $state.onboardingFinished, content: { MainCoordinator() })
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
      .environmentObject(app.state.onboardingState)
  }
}


private var cancellables = [String:AnyCancellable]()

extension Published {
  init(wrappedValue defaultValue: Value, key: String) {
    let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
    self.init(initialValue: value)
    cancellables[key] = projectedValue.sink { val in
      UserDefaults.standard.set(val, forKey: key)
    }
  }
}
