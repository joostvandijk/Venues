//
//  Venue.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

/// Structure describing a venue, as returned by the Foursquare backend.
public struct Venue: Unboxable {
    
    /// The identifier of the venue.
    public let identifier: String
    
    /// The name of the venue.
    public let name: String
    
    /// The rating of the venue, on a scale of 1.0 to 10.0.
    public let rating: Double
    
    /// The location of the venue.
    public let location: Location
    
    /// The categories related to the venue.
    public let categories: [Category]
    
    /// The featured photos of the venue.
    public let featuredPhotos: [Photo]
    
    /// The URL to the venue on the Foursquare website.
    public var url: URL {
        return URL(string: "https://foursquare.com/v/\(identifier)")!
    }
    
    /// Initializes the venue.
    ///
    /// - Parameter unboxer: The unboxer to use for retrieving the values.
    /// - Throws: An UnboxError in case an unrecoverable error occurrs.
    public init(unboxer: Unboxer) throws {
        identifier = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
        rating = try unboxer.unbox(key: "rating")
        location = try unboxer.unbox(key: "location")
        categories = try unboxer.unbox(key: "categories")
        featuredPhotos = try unboxer.unbox(keyPath: "featuredPhotos.items")
    }
    
}
