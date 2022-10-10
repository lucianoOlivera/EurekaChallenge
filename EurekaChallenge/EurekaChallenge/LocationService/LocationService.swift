//
//  LocationService.swift
//  EurekaChallenge
//
//  Created by lolivera on 09/10/2022.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationServiceDelegate {
  func didUpdateLocations(_ coordinates: CLLocationCoordinate2D)
}

class LocationService: NSObject {
  var delegate: LocationServiceDelegate?
  private var locationManager: CLLocationManager!
  
    // MARK: - Initializers
  override init() {
    super.init()
  }
  
    // MARK: - Methods
  func determineCurrentLocation() {
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    locationManager.requestAlwaysAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.requestLocation()
    }
  }
}

  // MARK: - Extensions
extension LocationService: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let userLocation: CLLocation = locations[0] as CLLocation
    
    if let delegate = delegate {
      delegate.didUpdateLocations(userLocation.coordinate)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error \(error)")
  }
}

