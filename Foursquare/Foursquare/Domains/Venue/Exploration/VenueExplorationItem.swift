//
//  VenueExplorationItem.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

public extension VenueExploration {
    
    /// Structure describing an item in a venue exploration.
    public struct Item: Unboxable {
        
        /// The venue embedded in the item.
        public let venue: Venue
        
        /// An array of reasons describing why the item was returned.
        public let reasons: [Reason]
        
        /// An array of tips that have been written about the embedded venue.
        public let tips: [Tip]
        
        /// Initializes the venue exploration item.
        ///
        /// - Parameter unboxer: The unboxer to use for retrieving the values.
        /// - Throws: An UnboxError in case an unrecoverable error occurrs.
        public init(unboxer: Unboxer) throws {
            venue = try unboxer.unbox(key: "venue")
            reasons = unboxer.unbox(keyPath: "reasons.items") ?? []
            tips = unboxer.unbox(key: "tips") ?? []
        }
        
    }
    
}
