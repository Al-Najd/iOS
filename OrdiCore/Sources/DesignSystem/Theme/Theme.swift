//
//  Theme.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 31/05/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//

import SwiftUI

public protocol Theme: Colorable, Shadowable { }

public final class ThemeManager {
  public var selectedTheme: Theme = PackageDefaultTheme()
  public var supportedThemes: [Theme] = [DefaultTheme()]
  public static var shared: ThemeManager = .init()
}
