//
//  LocationFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/02/2022.
//

import Foundation
import CoreLocation

public struct LocationState: Equatable {
  public var coordinates: CLLocationCoordinate2D = .init()
  
  public static func == (lhs: LocationState, rhs: LocationState) -> Bool {
    lhs.coordinates.latitude == rhs.coordinates.latitude
    && lhs.coordinates.longitude == rhs.coordinates.longitude
  }
  
  public init(coordinates: CLLocationCoordinate2D = .init()) {
    self.coordinates = coordinates
  }
}
