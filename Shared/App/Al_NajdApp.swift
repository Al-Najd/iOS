//
//  Al_NajdApp.swift
//  Shared
//
//  Created by Ahmed Ramy on 20/01/2022.
//

//import Common
//import ComposableArchitecture
//import Home
import SwiftUI
//import PulseUI

@main
struct Al_NajdApp: App {
//  @State var showPulse: Bool = false
//
//  let plugins: [AppPlugin] = [
//    CorePlugin(),
//    ThemePlugin(),
//    AppearancesPlugin(),
//    ReportPlugin(),
//  ]
//
//  init() {
//    plugins.forEach { $0.setup() }
//  }

  var body: some Scene {
    WindowGroup {
      RootView()
//      RootView(store: .mainRoot)
//        .onShake {
//          showPulse = true
//        }
//        .sheet(isPresented: $showPulse) {
//          NavigationView {
//              ConsoleView()
//              .navigationBarItems(leading: Button("Close") {
//                showPulse = false
//              })
//          }
//        }
    }
  }
}

//// The notification we'll send when a shake gesture happens.
//extension UIDevice {
//  static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
//}
//
////  Override the default behavior of shake gestures to send our notification instead.
//extension UIWindow {
//  open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//    if motion == .motionShake {
//      NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
//    }
//  }
//}
//
//// A view modifier that detects shaking and calls a function of our choosing.
//struct DeviceShakeViewModifier: ViewModifier {
//  let action: () -> Void
//
//  func body(content: Content) -> some View {
//    content
//      .onAppear()
//      .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
//        action()
//      }
//  }
//}
//
//// A View extension to make the modifier easier to use.
//extension View {
//  func onShake(perform action: @escaping () -> Void) -> some View {
//    self.modifier(DeviceShakeViewModifier(action: action))
//  }
//}
