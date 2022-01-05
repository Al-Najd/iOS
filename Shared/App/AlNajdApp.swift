//
//  AlNajdApp.swift
//  Shared
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import SwiftUI
import PartialSheet
import Combine

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
  
  let sheetManager: PartialSheetManager = PartialSheetManager()
  
  init() {
    plugins.forEach { $0.setup() }
  }
  
  var body: some Scene {
    WindowGroup {
      MainCoordinatorView()
        .environmentObject(app.state)
        .environmentObject(app.state.onboardingState)
        .environmentObject(app.state.homeState)
        .environmentObject(app.state.azkarState)
        .environmentObject(app.state.plansState)
        .environmentObject(app.state.rewardsState)
        .environmentObject(app.state.dateState)
        .environmentObject(sheetManager)
        .environment(\.colorScheme, .dark)
        .preferredColorScheme(.dark)
    }
  }
}



final class AppState: ObservableObject {
  @Published var onboardingState: OnboardingState = .init()
  @Published var homeState: PrayersState = .init()
  @Published var azkarState: AzkarState = .init()
  @Published var plansState: PlansState = .init()
  @Published var rewardsState: RewardsState = .init()
  @Published var dateState: DateState = .init()
  
  func sync(with dailyReport: DailyDeedsReport) {
    homeState.faraaid = dailyReport.faraaid
    homeState.nafila = dailyReport.nafila
    homeState.sunnah = dailyReport.sunnah
    homeState.accumlatedRewards = dailyReport.accumlatedPrayersRewards
    azkarState.sabah = dailyReport.sabah
    azkarState.masaa = dailyReport.masaa
    azkarState.accumlatedRewards = dailyReport.accumlatedAzkarRewards
  }
}

final class DateState: ObservableObject {
  @Published var selectedDate: Date = .now
  @Published var showDaySelection: Bool = false
  @Published var offset: CGFloat = 0
  var title: String {
    selectedDate.isInToday ? "Today".localized : "\(Date().day)-\(Date().month)-\(Date().year)"
  }
}

final class RewardsState: ObservableObject {
  var prayerRewards: [Deed] = []
  var azkarRewards: [RepeatableDeed] = []
  
  var noRewardsYet: Bool { prayerRewards.isEmpty && azkarRewards.isEmpty }
}

final class AppService {
  @ObservedObject var state: AppState = .init()
  
  private var todaysString: String {
    let date = state.dateState.selectedDate
    return "\(date.day)-\(date.month)-\(date.year)"
  }
  
  private var cancellables: Set<AnyCancellable> = .init()
  
  private var dailyReport: DailyDeedsReport {
    get {
      CacheManager().fetch(DailyDeedsReport.self, for: .daily(todaysString)) ?? .init()
    }
    
    set {
      try? CacheManager().save(newValue, for: .daily(todaysString))
    }
  }
  
  init() {
    state.dateState.$selectedDate.sink(receiveValue: { [weak self] _ in
      guard let self = self else { return }
      withAnimation(.easeInOut) {
        self.state.sync(with: self.dailyReport)
      }
    }).store(in: &cancellables)
  }
  
  var canShowBuffs: Bool {
    state.homeState.accumlatedRewards.isEmpty == false
  }
  
  func did(deed: Deed) {
    var deed = deed
    deed.isDone = true
    updateState(deed: deed)
    state.homeState.accumlatedRewards.append(deed)
    updateCache()
    MusicService.main.start(effect: .splashEnd)
    HapticService.main.generate(feedback: .success)
  }
  
  func undo(deed: Deed) {
    var deed = deed
    deed.isDone = false
    updateState(deed: deed)
    state.homeState.accumlatedRewards.findAndRemove(deed)
    updateCache()
    HapticService.main.generate(feedback: .warning)
  }
  
  func decrement(deed: RepeatableDeed) {
    guard deed.currentNumberOfRepeats > 0 else { return }
    var deed = deed
    deed.currentNumberOfRepeats -= 1
    updateState(repeatableDeed: deed)
    updateCache()
    if deed.currentNumberOfRepeats == 0 {
      state.azkarState.accumlatedRewards.findAndReplaceElseAppend(with: deed)
      MusicService.main.start(effect: .splashEnd)
    }
    
    HapticService.main.generate(feedback: .success)
  }
  
  func did(deed: RepeatableDeed) {
    var deed = deed
    deed.currentNumberOfRepeats = 0
    state.azkarState.accumlatedRewards.findAndReplaceElseAppend(with: deed)
    updateState(repeatableDeed: deed)
    updateCache()
    HapticService.main.generate(feedback: .warning)
  }
  
  func undo(deed: RepeatableDeed) {
    var deed = deed
    deed.currentNumberOfRepeats = deed.numberOfRepeats
    state.azkarState.accumlatedRewards.findAndReplaceElseAppend(with: deed)
    updateState(repeatableDeed: deed)
    updateCache()
    MusicService.main.start(effect: .splashEnd)
    HapticService.main.generate(feedback: .success)
  }
  
  private func updateCache() {
    dailyReport = .init(state: state)
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
  mutating func findAndReplaceElseAppend(with replacer: Element) {
    if let index = firstIndex(where: { $0.id == replacer.id }) {
      self[index] = replacer
    } else {
      self.append(replacer)
    }
  }
  
  mutating func findAndReplace(with replacer: Element) {
    guard let index = firstIndex(where: { $0.id == replacer.id }) else { return }
    self[index] = replacer
  }
  
  mutating func findAndRemove(_ target: Element) {
    removeAll(where: { $0.id == target.id })
  }
}
