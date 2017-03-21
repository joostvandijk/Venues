//
//  VenueExplorationTip.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

public extension VenueExploration {
    
    /// Structure describing a tip about a venue, written by a Foursquare user.
    public struct Tip: Unboxable {
        
        /// The text of the tip.
        public let text: String
        
        /// Initializes the venue exploration tip.
        ///
        /// - Parameter unboxer: The unboxer to use for retrieving the values.
        /// - Throws: An UnboxError in case an unrecoverable error occurrs.
        public init(unboxer: Unboxer) throws {
            text = try unboxer.unbox(key: "text")
        }
        
    }
    
}
