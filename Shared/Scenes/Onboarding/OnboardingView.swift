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
}

struct OnboardingView: View {
  @EnvironmentObject var state: OnboardingState
  
  var body: some View {
    SplashView()
      .fullScreenCover(isPresented: $state.startOnboarding, content: {
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
        }.fullScreenCover(isPresented: $state.onboardingFinished, content: { ContentView() })
      })
  }
  
  //private extension OnboardingView {
  //  func showFirstOnboardingView() {
  //
  //  }
  //}
  struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingView()
        .environmentObject(app.state.onboardingState)
    }
  }
  
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
}

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
