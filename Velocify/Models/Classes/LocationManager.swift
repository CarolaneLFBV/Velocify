    //
    //  LocationManager.swift
    //  Velocify
    //
    //  Created by Carolane LEFEBVRE on 06/03/2023.
    //

import CoreLocation
import Combine
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
        /// PassthroughSubject<Output, Failure> publishes events every time a data has changed
        /// Void: no particlar value to publish. Never: no error is triggered
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var speed: Double = 0.0 {
        willSet { objectWillChange.send() }
    }
    
    @Published var speedAccuracy: Double = 0.0 {
        willSet { objectWillChange.send() }
    }
        
    override init() {
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.startUpdatingLocation()
    }
    
    func didUpdateLocation() {
        
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if (location.speedAccuracy >= 0) {
            let s: Double = location.speed * 3.6
            self.speed = Double(s)
            self.speedAccuracy = Double(location.speedAccuracy * 3.6)
        }
    }
}
