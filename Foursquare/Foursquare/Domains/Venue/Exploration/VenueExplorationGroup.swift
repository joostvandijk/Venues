//
//  VenueExplorationGroup.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

public extension VenueExploration {
    
    /// Structure describing a group of items recommended in a venue exploration operation.
    public struct Group: Unboxable {
        
        /// The localized name of the group.
        public let name: String
        
        /// The items in the group.
        public let items: [Item]
        
        /// Initializes the venue exploration group.
        ///
        /// - Parameter unboxer: The unboxer to use for retrieving the values.
        /// - Throws: An UnboxError in case an unrecoverable error occurrs.
        public init(unboxer: Unboxer) throws {
            name = try unboxer.unbox(key: "type")
            items = try unboxer.unbox(key: "items")
        }
        
    }
    
}
