//
//  SettingsView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 24/10/2021.
//

import PulseUI
import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var settingsState: SettingsState
  @State var presentDebugMode = false
  var body: some View {
    List {
      Section(
        content: {
          Toggle(isOn: $settingsState.allowSounds) {
            Text("Sounds".localized)
              .font(.pFootnote)
          }
          Toggle(isOn: $settingsState.allowSFX) {
            Text("Sound Effects".localized)
              .font(.pFootnote)
          }
          Toggle(isOn: $settingsState.allowHaptic) {
            Text("Haptic Feedback".localized)
              .font(.pFootnote)
          }
      },
        header: {
          Text("Sounds & Haptic Feedback".localized)
            .font(.pHeadline)
        }
      )
      
      Button {
        presentDebugMode = true
      } label: {
        Text("Debug Mode")
      }.popover(isPresented: $presentDebugMode, content: { MainView() })
    }
  }
}
