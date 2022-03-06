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
    
    init(state: RootState) {
      self.isOnboardingPresented = state.onboardingState != nil
    }
  }
  
  public init(store: Store<RootState, RootAction>) {
    self.store = store
    self.viewStore = ViewStore(self.store.scope(state: ViewState.init))
  }
  
    public var body: some View {
      ZStack {
        if !viewStore.isOnboardingPresented {
          MainTabView(store: store)
            .zIndex(0)
        } else {
          IfLetStore(
            self.store.scope(state: \.onboardingState, action: RootAction.onboardingAction),
            then: OnboardingView.init(store:)
          )
            .zIndex(1)
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
