//
//  LocationController.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationControllerDelegate: class {
    func locationController(_ controller: LocationController, didObtainLocation location: CLLocation)
    func locationController(didFindDeniedPermission controller: LocationController)
}

/// Takes care of everything involved in fetching the device location.
/// If the corresponding permission has been granted, it will try to fetch the device location. Otherwise, it will request location permission or inform if it has been denied.
class LocationController: NSObject {

    weak var delegate: LocationControllerDelegate?
    
    fileprivate let manager: CLLocationManager
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
    
    /// This method will be triggered whenever the user taps the button to locate the map on the device's location.
    func start() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            requestLocationPermission()
        case .authorizedAlways, .authorizedWhenInUse:
            fetchCurrentLocation()
        case .denied, .restricted:
            delegate?.locationController(didFindDeniedPermission: self)
        @unknown default:
            print("Unexpected authorization status obtained from CLLocationManager.")
        }
    }
    
    private func requestLocationPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    private func fetchCurrentLocation() {
        manager.requestLocation()
    }
    
}

extension LocationController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            // Permission granted case: we are going to fetch the current location and inform it to the delegate.
            fetchCurrentLocation()
        case .denied, .restricted:
            // Permission denied/restricted case: we are going to just log the issue, and if the user taps the location button
            // again, they will be shown an alert indicating the situation.
            print("User denied permission to access location")
        case .notDetermined:
            // Ignore this case as we don't care about it.
            break
        @unknown default:
            print("Unexpected authorization status after requesting location access.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        delegate?.locationController(self, didObtainLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
