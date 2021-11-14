//
//  LocationService.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 05/11/2021.
//

import Foundation
import Combine
import CoreLocation

public final class LocationService: NSObject, CLLocationManagerDelegate {
  public let locationManager: CLLocationManager
  private let headingPublisher: PassthroughSubject<CLHeading, Error>
  public var publisher: AnyPublisher<CLHeading, Error>
  
  public override init() {
    locationManager = CLLocationManager()
    headingPublisher = PassthroughSubject<CLHeading, Error>()
    publisher = headingPublisher.eraseToAnyPublisher()
    
    super.init()
    locationManager.delegate = self
  }
  
  public func enable() {
    locationManager.startUpdatingHeading()
  }
  
  public func disable() {
    locationManager.stopUpdatingHeading()
  }
}

extension LocationService {
  // MARK - delegate methods
  public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    headingPublisher.send(newHeading)
  }
  
  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    headingPublisher.send(completion: Subscribers.Completion.failure(error))
  }
}
