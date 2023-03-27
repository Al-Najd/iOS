//
//  RootView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/03/2022.
//

import Assets
import ComposableArchitecture
import Dashboard
import DesignSystem
import Home
import Localization
import PrayerDetails
import SwiftUI
import Azkar
import Inject

// MARK: - RootView

public struct RootView: View {
  public let store: StoreOf<Root>

  public var body: some View {
    AzkarView()
  }
}
