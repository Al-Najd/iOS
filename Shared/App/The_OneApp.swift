//
//  The_OneApp.swift
//  Shared
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import SwiftUI

@main
struct The_OneApp: App {
  
  var plugins: [AppPlugin] {
    [
      ThemePlugin(),
      CorePlugin(),
      AppearancesPlugin(),
    ]
  }
  
  init() {
    plugins.forEach { $0.setup() }
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(app.state)
    }
  }
}

final class AppState: ObservableObject {
  @Published var sunnah: [Deed] = .sunnah
  @Published var faraaid: [Deed] = .faraaid
  @Published var nafila: [Deed] = .nafila
  
  @Published var accumlatedRewards: [Reward] = []
}

final class AppService {
  @ObservedObject var state: AppState = .init()
  
  func handle(deed: Deed) {
    deed.isDone ? undo(deed: deed) : did(deed: deed)
  }
  
  private func did(deed: Deed) {
    var deed = deed
    deed.isDone = true
    updateState(deed: deed)
    state.accumlatedRewards.append(deed.reward)
  }
  
  private func undo(deed: Deed) {
    var deed = deed
    deed.isDone = false
    updateState(deed: deed)
    state.accumlatedRewards.findAndRemove(deed.reward)
  }
  
  private func updateState(deed: Deed) {
    switch deed.category {
    case .fard:
      state.faraaid.findAndReplace(with: deed)
    case .sunnah:
      state.sunnah.findAndReplace(with: deed)
    case .nafila:
      state.nafila.findAndReplace(with: deed)
    }
  }
}

extension Array where Element: Identifiable {
  mutating func findAndReplace(with replacer: Element) {
    guard let index = firstIndex(where: { $0.id == replacer.id }) else { return }
    self[index] = replacer
  }
  
  mutating func findAndRemove(_ target: Element) {
    removeAll(where: { $0.id == target.id })
  }
}
