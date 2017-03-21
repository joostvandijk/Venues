//
//  VenueLocation.swift
//  Foursquare
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

public extension Venue {
    
    /// Structure describing a venue's location, as returned by the Foursquare backend.
    public struct Location: Unboxable {
        
        /// The address of the venue.
        public let address: String?
        
        /// The postal code of the venue.
        public let postalCode: String?
        
        /// The city of the venue.
        public let city: String?
        
        /// The state of the venue.
        public let state: String?
        
        /// The country of the venue.
        public let country: String?
        
        /// The distance to the venue in meters.
        public let distance: Double?
        
        /// Initializes the venue location.
        ///
        /// - Parameter unboxer: The unboxer to use for retrieving the values.
        /// - Throws: An UnboxError in case an unrecoverable error occurrs.
        public init(unboxer: Unboxer) throws {
            address = unboxer.unbox(key: "address")
            postalCode = unboxer.unbox(key: "postalCode")
            city = unboxer.unbox(key: "city")
            state = unboxer.unbox(key: "state")
            country = unboxer.unbox(key: "country")
            distance = unboxer.unbox(key: "distance")
        }
        
    }
    
}
