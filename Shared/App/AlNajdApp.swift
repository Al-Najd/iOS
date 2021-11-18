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
        .environmentObject(app.state.homeState)
        .environmentObject(app.state.azkarState)
        .environment(\.colorScheme, .dark)
        .preferredColorScheme(.dark)
    }
  }
}

final class AppState: ObservableObject {
  @Published var onboardingState: OnboardingState = .init()
  @Published var homeState: PrayersState = .init()
  @Published var azkarState: AzkarState = .init()
}

final class AppService {
  @ObservedObject var state: AppState = .init()
  
  var canShowBuffs: Bool {
    state.homeState.accumlatedRewards.isEmpty == false
  }
  
  func did(deed: Deed) {
    var deed = deed
    deed.isDone = true
    updateState(deed: deed)
    state.homeState.accumlatedRewards.append(deed)
    MusicService.main.start(effect: .splashEnd)
    HapticService.main.generate(feedback: .success)
  }
  
  func undo(deed: Deed) {
    var deed = deed
    deed.isDone = false
    updateState(deed: deed)
    state.homeState.accumlatedRewards.findAndRemove(deed)
    HapticService.main.generate(feedback: .warning)
  }
  
  func did(deed: RepeatableDeed) {
    var deed = deed
    deed.numberOfRepeats = max(0, deed.numberOfRepeats - 1)
    if deed.numberOfRepeats == 0 {
      state.azkarState.accumlatedRewards.append(deed)
      MusicService.main.start(effect: .splashEnd)
    }
    updateState(repeatableDeed: deed)
    HapticService.main.generate(feedback: .success)
  }
  
  private func updateState(deed: Deed) {
    switch deed.category {
    case .fard:
      state.homeState.faraaid.findAndReplace(with: deed)
    case .sunnah:
      state.homeState.sunnah.findAndReplace(with: deed)
    case .nafila:
      state.homeState.nafila.findAndReplace(with: deed)
    default:
      break
    }
  }
  
  private func updateState(repeatableDeed: RepeatableDeed) {
    switch repeatableDeed.category {
    case let .azkar(category):
      switch category {
      case .sabah:
        state.azkarState.sabah.findAndReplace(with: repeatableDeed)
      case .masaa:
        state.azkarState.masaa.findAndReplace(with: repeatableDeed)
      }
    default:
      break
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
