//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 04/03/2022.
//

//public final class AppDelegate: NSObject, UIApplicationDelegate {
//  public let store = Store<RootState, RootAction>(
//    initialState: RootState(),
//    reducer: rootReducer,
//    environment: CoreEnvironment.live(RootEnvironment())
//  )
//  
//  public lazy var viewStore = ViewStore(
//    self.store.scope(state: .init()),
//    removeDuplicates: ==
//  )
//  
//  public func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
//  ) -> Bool {
//    self.viewStore.send(.appDelegateAction(.didFinishLaunching))
//    return true
//  }
//}
