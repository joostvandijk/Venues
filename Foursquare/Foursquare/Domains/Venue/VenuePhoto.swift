//
//  VenuePhoto.swift
//  Foursquare
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

public extension Venue {
    
    /// Structure describing a venue photo, as returned by the Foursquare backend.
    public struct Photo: Unboxable {
        
        /// The identifier of the photo.
        public let identifier: String
        
        /// The size of the photo.
        public let size: CGSize
        
        /// The prefix of the path of the photo.
        public let prefix: String
        
        /// The suffix of the path of the photo.
        public let suffix: String
        
        /// Initializes the venue photo.
        ///
        /// - Parameter unboxer: The unboxer to use for retrieving the values.
        /// - Throws: An UnboxError in case an unrecoverable error occurrs.
        public init(unboxer: Unboxer) throws {
            let width: Double = try unboxer.unbox(key: "width")
            let height: Double = try unboxer.unbox(key: "height")
            
            identifier = try unboxer.unbox(key: "id")
            size = CGSize(width: width, height: height)
            prefix = try unboxer.unbox(key: "prefix")
            suffix = try unboxer.unbox(key: "suffix")
        }
        
    }
    
}
