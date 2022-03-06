//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import ComposableArchitecture
import Dashboard
import Prayers
import Azkar
import Rewards
import Date
import Settings
import Location

struct HomeFeature: Equatable {
  var locationState: LocationState
  var dashboardState: DashboardState
  var prayerState: PrayerState
  var azkarState: AzkarState
  var rewardState: RewardsState
  var dateState: DateState
  var settingsState: SettingsState
}
