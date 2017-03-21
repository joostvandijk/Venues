//
//  VenueExploration.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation
import CoreLocation

/// Structure that contains venues near a given location, as returned by the Foursquare backend.
public struct VenueExploration: Unboxable {
    
    /// A description of the location around which venues are explored.
    public let location: String?
    
    /// An array of groups, each containing items that were found in the venue exploration operation.
    public let groups: [Group]
    
    /// Initializes the venue exploration structure.
    ///
    /// - Parameter unboxer: The unboxer to use for retrieving the values.
    /// - Throws: An UnboxError in case an unrecoverable error occurrs.
    public init(unboxer: Unboxer) throws {
        location = unboxer.unbox(key: "headerLocation")
        groups = try unboxer.unbox(key: "groups")
    }
    
}

// MARK: Requests

public extension VenueExploration {
    
    /// Creates and returns a request to retrieve venues near a given location.
    ///
    /// - Parameters:
    ///   - location: The location for which to retrieve nearby venues.
    ///   - offset: The offset of the returned results, usable for pagination.
    /// - Returns: A request to retrieve venues near a given location.
    public static func request(near location: CLLocation, offset: Int? = 0) -> Request<VenueExploration> {
        let coordinates = [location.coordinate.latitude,
                           location.coordinate.longitude].map { String($0) }.joined(separator: ",")
        
        let urlParameters = ["ll": coordinates,
                             "offset": String(offset ?? 0),
                             "venuePhotos": "1"]
        
        return Request(path: "venues/explore", urlParameters: urlParameters)
    }
    
}
