//
//  ApplicationLifecycleEventPlugin.swift
//  CAFU
//
//  Created by Ahmed Ramy on 17/12/2022.
//

import Foundation
import UIKit

// MARK: - ApplicationLifecycleEventPlugin

public protocol ApplicationLifecycleEventPlugin: ApplicationPlugin {
    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool

    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication)
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication)

    func applicationWillTerminate(_ application: UIApplication)
    func applicationDidReceiveMemoryWarning(_ application: UIApplication)
}

public extension ApplicationLifecycleEventPlugin {
    func application(
        _: UIApplication,
        willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool { true }
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool { true }
    func application(
        _: UIApplication,
        continue _: NSUserActivity,
        restorationHandler _: @escaping ([UIUserActivityRestoring]?) -> Void)
        -> Bool { false }

    func applicationProtectedDataWillBecomeUnavailable(_: UIApplication) { }
    func applicationProtectedDataDidBecomeAvailable(_: UIApplication) { }

    func applicationWillTerminate(_: UIApplication) { }
    func applicationDidReceiveMemoryWarning(_: UIApplication) { }
}
