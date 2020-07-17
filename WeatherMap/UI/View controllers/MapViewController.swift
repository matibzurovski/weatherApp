//
//  MapViewController.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet fileprivate(set) weak var mapView: MKMapView!
    
    fileprivate let locationController = LocationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Map logic
fileprivate extension MapViewController {
    
    func moveMap(to location: CLLocation) {
        let camera = MKMapCamera(lookingAtCenter: location.coordinate, fromDistance: 6000, pitch: 0, heading: 0)
        mapView.setCamera(camera, animated: false)
    }
}

// MARK: - Actions
fileprivate extension MapViewController {
    
    @IBAction func locationButtonAction(_ sender: Any) {
        locationController.delegate = self
        locationController.start()
    }
    
}

// MARK: - LocationControllerDelegate
extension MapViewController: LocationControllerDelegate {
    
    func locationController(_ controller: LocationController, didObtainLocation location: CLLocation) {
        moveMap(to: location)
    }
    
    func locationController(didFindDeniedPermission controller: LocationController) {
        let alert = UIAlertController(title: "Permission denied 😞", message: "It seems like you have rejected location access to WeatherMap.\n\nPlease grant access through the device settings if you want to get a more accurate location on the map!", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let openSettingsAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString),UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(dismissAction)
        alert.addAction(openSettingsAction)
        present(alert, animated: true)
    }
    
    
}
