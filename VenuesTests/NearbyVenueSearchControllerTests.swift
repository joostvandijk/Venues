//
//  NearbyVenueSearchControllerTests.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import XCTest
@testable import Venues

class NearbyVenueSearchControllerTests: XCTestCase {
    
    func testVenueServiceError() {
        let venueService = MockVenueService(behavior: .returnError)
        let userLocationService = MockUserLocationService()
        let nearbyVenueSearchController = NearbyVenueSearchController(venueService: venueService, userLocationService: userLocationService)
        
        nearbyVenueSearchController.requestNearbyVenues { result in
            XCTAssertTrue(result.isFailure)
        }
    }
    
    func testUserLocationError() {
        let venueService = MockVenueService()
        let userLocationService = MockUserLocationService(behavior: .returnAuthorizationError)
        let nearbyVenueSearchController = NearbyVenueSearchController(venueService: venueService, userLocationService: userLocationService)
        
        nearbyVenueSearchController.requestNearbyVenues { result in
            XCTAssertTrue(result.isFailure)
        }
    }
    
    func testRequestingUserLocationOnce() {
        let venueService = MockVenueService()
        let userLocationService = MockUserLocationService()
        let nearbyVenueSearchController = NearbyVenueSearchController(venueService: venueService, userLocationService: userLocationService)
        
        // After requesting nearby venues, the number of location requests should equal 1.
        nearbyVenueSearchController.requestNearbyVenues { _ in }
        XCTAssertEqual(userLocationService.numberOfLocationRequests, 1)
        
        // After requesting nearby venues again, the search controller should use the previous location, so no location requests should be made.
        nearbyVenueSearchController.requestNearbyVenues { _ in }
        XCTAssertEqual(userLocationService.numberOfLocationRequests, 1)
    }
    
    func testRequestingUserLocationAfterPreviousRequestFailed() {
        let venueService = MockVenueService()
        let userLocationService = MockUserLocationService(behavior: .returnAuthorizationError)
        let nearbyVenueSearchController = NearbyVenueSearchController(venueService: venueService, userLocationService: userLocationService)
        
        nearbyVenueSearchController.requestNearbyVenues { result in
            XCTAssertTrue(result.isFailure)
        }
        
        userLocationService.behavior = .returnLocation
        
        nearbyVenueSearchController.requestNearbyVenues { result in
            XCTAssertTrue(result.isSuccess)
        }
    }
    
}
