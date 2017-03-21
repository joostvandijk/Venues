//
//  NearbyVenueSearchController.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation
import CoreLocation

/// The NearbyVenueSearchController searches for venues near the user's current location.
/// It's responsible for obtaining the user's current location and requesting venues near that location.
public class NearbyVenueSearchController {
    
    /// The service to use to request venues.
    public let venueService: VenueService
    
    /// The service to use to request the user's current location.
    public let userLocationService: UserLocationService
    
    /// Initializes the nearby venue search controller.
    ///
    /// - Parameters:
    ///   - venueService: The service to use to request venues.
    ///   - userLocationService: The service to use to request the user's current location.
    public init(venueService: VenueService, userLocationService: UserLocationService) {
        self.venueService = venueService
        self.userLocationService = userLocationService
    }
    
    // MARK: Requesting Nearby Venues
    
    public func requestNearbyVenues(completionHandler: @escaping (Result<Venues>) -> Void) {
        func requestVenues(near location: CLLocation) {
            venueService.requestVenues(near: location, offset: nil) { result in
                completionHandler(result)
            }
        }
        
        // When we already have a location, start searching immediately.
        if let currentLocation = currentLocation {
            requestVenues(near: currentLocation)
            
            return
        }
        
        // If we don't have a location yet, request one first.
        userLocationService.requestCurrentLocation { result in
            switch result {
            case let .success(location):
                self.currentLocation = location
                
                requestVenues(near: location)
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private var currentLocation: CLLocation?
    
}
