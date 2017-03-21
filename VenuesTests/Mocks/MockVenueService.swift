//
//  MockVenueService.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Venues

class MockVenueService: VenueService {
    
    enum Behavior {
        case returnVenues
        case returnError
    }
    
    var behavior: Behavior
    
    init(behavior: Behavior = .returnVenues) {
        self.behavior = behavior
    }
    
    func requestVenues(near location: CLLocation, offset: Int?, completionHandler: @escaping (Result<Venues>) -> Void) {
        switch behavior {
        case .returnVenues:
            completionHandler(.success(sampleVenues))
        case .returnError:
            let error = NSError(domain: "test-domain", code: 101, userInfo: nil)
            completionHandler(.failure(error))
        }
    }
    
    private var sampleVenues: Venues {
        return [Venue(identifier: "1", name: "Kasteel Doorwerth", rating: 8.2, tip: "Nice to walk around"),
                Venue(identifier: "2", name: "Airborne Museum", rating: 8.9, tip: "Follow the footsteps of the British troops"),
                Venue(identifier: "3", name: "De Kromme Dissel", rating: 8.4, tip: "The food is just amazing"),
                Venue(identifier: "4", name: "Sportcentrum Papendal", rating: 8.8, tip: "Good showers")]
    }
    
}
