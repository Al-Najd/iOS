//
//  File.swift
//
//
//  Created by Ahmed Ramy on 16/02/2022.
//

import UIKit.UIApplication

public func openSettings() {
    #if os(macOS)
    NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
    #else
    let suffix = Bundle.main.bundleIdentifier ?? ""
    let urlString = UIApplication.openSettingsURLString.withSuffix(suffix)
    guard let url = URL(string: urlString) else { return }

    UIApplication.shared.open(url)
    #endif
}
