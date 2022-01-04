//
//  DailyDeedsReport.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 04/01/2022.
//

import Foundation

public final class DailyDeedsReport: Cachable {
  var sunnah: [Deed] = .sunnah
  var faraaid: [Deed] = .faraaid
  var nafila: [Deed] = .nafila
  var accumlatedPrayersRewards: [Deed] = []
  
  var sabah: [RepeatableDeed] = .sabah
  var masaa: [RepeatableDeed] = .masaa
  var accumlatedAzkarRewards: [RepeatableDeed] = []
  
  init() { }
  
  init(state: AppState) {
    self.sunnah = state.homeState.sunnah
    self.faraaid = state.homeState.faraaid
    self.nafila = state.homeState.nafila
    self.accumlatedPrayersRewards = state.homeState.accumlatedRewards
    self.sabah = state.azkarState.sabah
    self.masaa = state.azkarState.masaa
    self.accumlatedAzkarRewards = state.azkarState.accumlatedRewards
  }
}
