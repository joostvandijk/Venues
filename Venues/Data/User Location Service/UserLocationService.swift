//
//  UserLocationService.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation
import CoreLocation

/// Instances conforming to this protocol provide a method to request the user's current location.
public protocol UserLocationService {
    
    /// Alias for the completion handler of user location requests.
    typealias CompletionHandler = (Result<CLLocation>) -> Void
    
    /// Requests the user's current location.
    ///
    /// - Parameter completionHandler: The completion handler to invoke when the request finishes.
    func requestCurrentLocation(completionHandler: @escaping CompletionHandler)
    
}

/// Enum describing the possible errors that can occurr during a request for the user's current location.
public enum UserLocationServiceError: Error {
    
    /// Indicates that a request for the user's location was denied by the user.
    case authorizationDenied
    
    /// Indicates that an unknown error occurred.
    case unknown
    
}
