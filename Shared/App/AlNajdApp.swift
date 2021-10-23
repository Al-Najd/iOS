//
//  AlNajdApp.swift
//  Shared
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import SwiftUI

@main
struct AlNajdApp: App {
  
  var plugins: [AppPlugin] {
    [
      ThemePlugin(),
      CorePlugin(),
      AppearancesPlugin(),
      ReportPlugin(),
    ]
  }
  
  init() {
    plugins.forEach { $0.setup() }
  }
  
  var body: some Scene {
    WindowGroup {
      OnboardingCoordinatorView()
        .environmentObject(app.state)
        .environmentObject(app.state.onboardingState)
    }
  }
}

final class AppState: ObservableObject {
  @Published var sunnah: [Deed] = .sunnah
  @Published var faraaid: [Deed] = .faraaid
  @Published var nafila: [Deed] = .nafila
  
  @Published var accumlatedRewards: [Deed] = []
  @Published var showBuffs: Bool = false
  
  @Published var onboardingState: OnboardingState = .init()
}

final class AppService {
  @ObservedObject var state: AppState = .init()
  
  func handle(deed: Deed) {
    deed.isDone ? undo(deed: deed) : did(deed: deed)
  }
  
  var canShowBuffs: Bool {
    state.accumlatedRewards.isEmpty == false
  }
  
  private func did(deed: Deed) {
    var deed = deed
    deed.isDone = true
    updateState(deed: deed)
    state.accumlatedRewards.append(deed)
    MusicService.main.start(effect: .splashEnd)
    HapticService.main.generate(feedback: .success)
  }
  
  private func undo(deed: Deed) {
    var deed = deed
    deed.isDone = false
    updateState(deed: deed)
    state.accumlatedRewards.findAndRemove(deed)
    HapticService.main.generate(feedback: .warning)
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
