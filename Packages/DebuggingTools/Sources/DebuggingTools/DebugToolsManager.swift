//
//  DebugToolsManager.swift
//  CAFU
//
//  Created by Ahmed Allam on 01/09/2022.
//
#if !PROD
import Navigation
import SwiftUI
import UIKit

extension UIWindow {
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with _: UIEvent?) {
        guard motion == .motionShake else { return }
        guard (AppRouter.shared.visibleViewController is UIHostingController<DebugView>) == false else { return }
        AppRouter.shared.visibleViewController?.present(DebugView().embedInHost(), animated: true)
    }
}
#endif
