//
//  RootView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/03/2022.
//

import SwiftUI
import ComposableArchitecture
import Onboarding

public struct RootView: View {
  public let store: Store<RootState, RootAction>
  @ObservedObject var viewStore: ViewStore<ViewState, RootAction>
  @Environment(\.deviceState) var deviceState
  
  struct ViewState: Equatable {
    let isOnboardingPresented: Bool
    let didFinishOnboarding: Bool
    
    init(state: RootState) {
      self.isOnboardingPresented = state.onboardingState != nil
      self.didFinishOnboarding = state.onboardingState?.didFinishOnboarding ?? true
    }
  }
  
  public init(store: Store<RootState, RootAction>) {
    self.store = store
    self.viewStore = ViewStore(self.store.scope(state: ViewState.init))
  }
  
    public var body: some View {
      Group {
        if !viewStore.isOnboardingPresented {
          SplashView {
            MainTabView(store: store)
          }
        } else {
          ZStack {
            if viewStore.didFinishOnboarding {
              SplashView {
                MainTabView(store: store)
              }
            }
            
            IfLetStore(
              self.store.scope(state: \.onboardingState, action: RootAction.onboardingAction),
              then: OnboardingView.init(store:)
            )
          }
        }
      }
      .modifier(DeviceStateModifier())
      .onAppear {
        viewStore.send(.onAppear)
      }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
      RootView(store: .init(initialState: .init(), reducer: rootReducer, environment: .live(.init())))
    }
}
