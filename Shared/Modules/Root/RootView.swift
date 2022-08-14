//
//  RootView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/03/2022.
//

import SwiftUI
import ComposableArchitecture
import Home

public struct RootView: View {
  public let store: Store<RootState, RootAction>
  @Environment(\.deviceState) var deviceState
  
  public init(store: Store<RootState, RootAction>) {
    self.store = store
  }
  
    public var body: some View {
      WithViewStore(store) { viewStore in
        SplashView {
          HomeView()
        }
        .modifier(DeviceStateModifier())
        .onAppear {
          viewStore.send(.onAppear)
        }
      }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
      RootView(store: .init(initialState: .init(), reducer: rootReducer, environment: .live(.init())))
    }
}
