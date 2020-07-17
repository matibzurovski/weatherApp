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
    @IBOutlet weak var lastWeatherButton: UIButton!
    fileprivate var activityView: UIActivityIndicatorView?
    
    fileprivate let locationController = LocationController()
    fileprivate let weatherController = WeatherController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationController.delegate = self
        weatherController.delegate = self
        updateLastWeatherButtonVisibility()
        setUpGestureRecognizer()
    }
}

// MARK: - UI setup
fileprivate extension MapViewController {
    
    func updateLastWeatherButtonVisibility() {
        lastWeatherButton.isHidden = !weatherController.isCacheInfoAvailable
    }
    
    func setUpGestureRecognizer() {
        /*
         NOTE: I've decided to change a little bit the requirement, and instead of showing the weather info
         after two taps on a location, I decided to make it after one long press gesture. This is because the
         double tap is used to zoom in the map, and I think it is better to leave that default behavior.
         As a future enhancement, we could add special annotations to the map that could be easily tapped to fetch
         the weather information on such place.
         
         This is how the code would look for the double taps requirement.
         
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
         tapGesture.numberOfTapsRequired = 2
        */
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleDoubleTap(sender: Any) {
        guard let gesture = sender as? UILongPressGestureRecognizer else { return }
        
        let tapPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        
        showLoadingIndicator()
        weatherController.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    private func showLoadingIndicator() {
        if activityView?.isAnimating ?? false {
            return
        }
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = view.center
        activityView.hidesWhenStopped = true
        view.addSubview(activityView)
        activityView.startAnimating()
        self.activityView = activityView
    }
    
    private func hideLoadingIndicator() {
        activityView?.stopAnimating()
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
    
    @IBAction func lastWeatherAction(_ sender: Any) {
        guard let info = weatherController.lastWeather else {
            print("Unexpected tap to check last weather when no info was available")
            return
        }
        
        let vc = WeatherViewController(info: info)
        present(vc, animated: true)
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

// MARK: - WeatherControllerDelegate
extension MapViewController: WeatherControllerDelegate {

    func weatherController(_ controller: WeatherController, didObtainWeather info: WeatherInfo) {
        hideLoadingIndicator()
        
        let vc = WeatherViewController(info: info)
        present(vc, animated: true)
        lastWeatherButton.isHidden = false
    }
    
    func weatherController(_ controller: WeatherController, didFailWithError error: Error) {
        hideLoadingIndicator()
        
        /// We aren't going to show the `error.localizedDescription` to the user because it is a third party library and we don't know how user friendly its errors are..
        let alert = UIAlertController(title: "Ooopss..", message: "We haven't been able to fetch the weather for the selected location. Please try again!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
