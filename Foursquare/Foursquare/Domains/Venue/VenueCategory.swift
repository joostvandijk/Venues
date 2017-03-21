//
//  VenueCategory.swift
//  Foursquare
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

public extension Venue {
    
    /// Structure describing a venue category, as returned by the Foursquare backend.
    public struct Category: Unboxable {
        
        /// The identifier of the category.
        public let identifier: String
        
        /// The name of the category.
        public let name: String
        
        /// The short name of the category.
        public let shortName: String
        
        /// The plural name of the category.
        public let pluralName: String
        
        /// Initializes the venue category.
        ///
        /// - Parameter unboxer: The unboxer to use for retrieving the values.
        /// - Throws: An UnboxError in case an unrecoverable error occurrs.
        public init(unboxer: Unboxer) throws {
            identifier = try unboxer.unbox(key: "id")
            name = try unboxer.unbox(key: "name")
            shortName = try unboxer.unbox(key: "shortName")
            pluralName = try unboxer.unbox(key: "pluralName")
        }
        
    }
    
}
