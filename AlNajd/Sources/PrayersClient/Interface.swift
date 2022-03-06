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

public struct PrayersClient {
    public var prayers: (CLLocationCoordinate2D) -> Effect<PrayerScheduleResponse, OError>
}
