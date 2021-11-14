//
//  SettingsView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 24/10/2021.
//

import PulseUI
import SwiftUI

struct SettingsView: View {
  @State var presentDebugMode = false
  var body: some View {
    Button {
      presentDebugMode = true
    } label: {
      Text("Debug Mode")
    }.popover(isPresented: $presentDebugMode, content: { MainView() })
  }
}
