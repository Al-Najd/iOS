//
//  RootView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/03/2022.
//

import SwiftUI
import Onboarding
import ComposableArchitecture

public struct RootView: View {
  public let store: Store<RootState, RootAction>
  @ObservedObject public var viewStore: ViewStore<ViewState, RootAction>
  @Environment(\.deviceState) public var deviceState

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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
      RootView(store: .init(initialState: .init(), reducer: rootReducer, environment: .live(.init())))
    }
}
