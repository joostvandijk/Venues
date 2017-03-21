//
//  MockUserLocationService.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Venues

class MockUserLocationService: UserLocationService {
    
    enum Behavior {
        case returnLocation
        case returnAuthorizationError
    }
    
    var behavior: Behavior
    
    init(behavior: Behavior = .returnLocation) {
        self.behavior = behavior
    }
    
    func requestCurrentLocation(completionHandler: @escaping UserLocationService.CompletionHandler) {
        numberOfLocationRequests += 1
        
        switch behavior {
        case .returnLocation:
            completionHandler(.success(sampleLocation))
        case .returnAuthorizationError:
            completionHandler(.failure(UserLocationServiceError.authorizationDenied))
        }
    }
    
    private(set) var numberOfLocationRequests = 0
    
    private var sampleLocation: CLLocation {
        return CLLocation(latitude: 51.983325, longitude: 5.904564)
    }
    
}

