//
//  VenueExplorationReason.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

public extension VenueExploration {
    
    /// Structure describing the reason why a venue was returned in the venue exploration operation.
    public struct Reason: Unboxable {
        
        /// A localized, textual description of the reason.
        public let description: String
        
        /// Initializes the venue exploration reason.
        ///
        /// - Parameter unboxer: The unboxer to use for retrieving the values.
        /// - Throws: An UnboxError in case an unrecoverable error occurrs.
        public init(unboxer: Unboxer) throws {
            description = try unboxer.unbox(keyPath: "summary")
        }
        
    }
    
}
