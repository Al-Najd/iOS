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
    public var prayers: [ANPrayer] = .faraaid
    
    public mutating func onDoing(prayer: ANPrayer) {
        prayers.replace(prayer, with: prayer.changing { $0.isDone.toggle() })
    }
    
    public mutating func onDoing(sunnah: ANSunnah, of prayer: ANPrayer) {
        prayers
            .replace(
                prayer,
                with: prayer.changing {
                    $0.sunnah.replace(sunnah, with: sunnah.changing { $0.isDone.toggle() })
                }
            )
    }
    
    public mutating func onDoing(zekr: ANAzkar, of prayer: ANPrayer) {
        prayers
            .replace(
                prayer,
                with: prayer.changing {
                    $0.afterAzkar.replace(zekr, with: zekr.changing { $0.currentCount = max(0, $0.currentCount - 1) })
                }
            )
    }
    
    public mutating func onFinishingZekr(zekr: ANAzkar, of prayer: ANPrayer) {
        prayers
            .replace(
                prayer,
                with: prayer.changing {
                    $0.afterAzkar.replace(zekr, with: zekr.changing { $0.currentCount = 0 })
                }
            )
    }
}

public extension Prayer {
  
}
