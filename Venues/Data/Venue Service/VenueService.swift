//
//  VenueService.swift
//  Venues
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation
import CoreLocation

/// Types conforming to the VenueService protocol can retrieve venues near a given location.
public protocol VenueService {
    
    /// Alias describing the completion handler used for requests.
    typealias CompletionHandler<ResponseType> = (Result<ResponseType>) -> Void
    
    /// Requests venues near a given location.
    ///
    /// - Parameters:
    ///   - location: The location to search for nearby venues.
    ///   - offset: The offset of the returned venues, used to paginate to a new set of venues.
    ///   - completionHandler: The completion handler to invoke when the request is completed.
    func requestVenues(near location: CLLocation, offset: Int?, completionHandler: @escaping CompletionHandler<Venues>)
    
}
