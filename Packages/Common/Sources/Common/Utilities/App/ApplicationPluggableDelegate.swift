//
//  ApplicationPluggableDelegate.swift
//  CAFU
//
//  Created by Ahmed Ramy on 09/09/2022.
//

import UIKit.UIApplication
import UIKit.UIWindow

// MARK: - ApplicationPluggableDelegate

/// Subclassed by the `AppDelegate` to pass lifecycle events to loaded plugins.
///
/// The application plugins will be processed in sequence after calling `plugins() -> [ApplicationPlugin]`.
///
///     @UIApplicationMain
///     class AppDelegate: ApplicationPluggableDelegate {
///
///         override func plugins() -> [ApplicationPlugin] {[
///             LoggerPlugin(),
///             NotificationPlugin()
///         ]}
///     }
///
/// Each application plugin has access to the `AppDelegate` lifecycle events:
///
///     struct LoggerPlugin: ApplicationPlugin {
///         private let log = Logger()
///
///         func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
///             log.config(for: application)
///             return true
///         }
///
///         func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
///             log.info("App did finish launching.")
///             return true
///         }
///
///         func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
///             log.warning("App did receive memory warning.")
///         }
///
///         func applicationWillTerminate(_ application: UIApplication) {
///             log.warning("App will terminate.")
///         }
///     }
open class ApplicationPluggableDelegate: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?

    /// List of application plugins for binding to `AppDelegate` events
    public private(set) lazy var pluginInstances: [ApplicationPlugin] = plugins()

    override public init() {
        super.init()

        // Load lazy property early
        _ = pluginInstances
    }

    /// List of application plugins for binding to `AppDelegate` events
    open func plugins() -> [ApplicationPlugin] { [] } // Override
}

// MARK: - Lifecycle Delegate Methods
extension ApplicationPluggableDelegate {
    open func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
        -> Bool {
        // Ensure all delegates called even if condition fails early
        // swiftlint:disable reduce_boolean
        pluginInstances.compactMap { $0 as? ApplicationLifecycleEventPlugin }.reduce(true) {
            $0 && $1.application(application, willFinishLaunchingWithOptions: launchOptions)
        }
    }

    open func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {
        // Ensure all delegates called even if condition fails early
        // swiftlint:disable reduce_boolean
        pluginInstances.compactMap { $0 as? ApplicationLifecycleEventPlugin }.reduce(true) {
            $0 && $1.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
    }

    open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        pluginInstances.compactMap { $0 as? ApplicationLifecycleEventPlugin }
            .forEach { $0.applicationProtectedDataWillBecomeUnavailable(application) }
    }

    open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        pluginInstances.compactMap { $0 as? ApplicationLifecycleEventPlugin }
            .forEach { $0.applicationProtectedDataDidBecomeAvailable(application) }
    }

    open func applicationWillTerminate(_ application: UIApplication) {
        pluginInstances.compactMap { $0 as? ApplicationLifecycleEventPlugin }.forEach { $0.applicationWillTerminate(application) }
    }

    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        pluginInstances.compactMap { $0 as? ApplicationLifecycleEventPlugin }
            .forEach { $0.applicationDidReceiveMemoryWarning(application) }
    }
}
