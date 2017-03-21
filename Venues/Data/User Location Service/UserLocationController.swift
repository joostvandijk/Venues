//
//  UserLocationController.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation
import CoreLocation

/// The UserLocationController class uses CoreLocation's CLLocationManager to implement the UserLocationService protocol.
public class UserLocationController: NSObject, CLLocationManagerDelegate, UserLocationService {
    
    /// Requests the user's current location.
    ///
    /// - Parameter completionHandler: The completion handler to invoke when the request finishes.
    public func requestCurrentLocation(completionHandler: @escaping UserLocationService.CompletionHandler) {
        requestCompletionHandler = completionHandler
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied, .restricted:
            let error = UserLocationServiceError.authorizationDenied
            finishCurrentLocationRequest(with: .failure(error))
        }
    }
    
    private func finishCurrentLocationRequest(with result: Result<CLLocation>) {
        requestCompletionHandler?(result)
        requestCompletionHandler = nil
    }
    
    private var requestCompletionHandler: UserLocationService.CompletionHandler?
    
    // MARK: Location Manager
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        return locationManager
    }()
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            let error = UserLocationServiceError.authorizationDenied
            finishCurrentLocationRequest(with: .failure(error))
        case .notDetermined:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Not sure if this ever happens, but handle the case of an empty array anyway.
        if let location = locations.last {
            finishCurrentLocationRequest(with: .success(location))
        } else {
            let error = UserLocationServiceError.unknown
            finishCurrentLocationRequest(with: .failure(error))
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        finishCurrentLocationRequest(with: .failure(error))
    }
    
}
