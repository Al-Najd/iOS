//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import Foundation
import Entities
import CoreLocation
import ComposableCoreLocation
import ComposableArchitecture
import Business
import Entity
import Adhan

public struct PrayersClient {
}

public extension Prayer {
  var prayerDetails: ANPrayer {
    switch self {
    case .fajr:
      return .fajr
    case .sunrise:
      return .sunrise
    case .dhuhr:
      return .dhuhr
    case .asr:
      return .asr
    case .maghrib:
      return .maghrib
    case .isha:
      return .isha
    }
  }
}
