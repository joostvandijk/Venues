//
//  Venue.swift
//  Venues
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit

/// Structure describing a venue.
public struct Venue {
    
    /// The Foursquare identifier of the venue.
    public let identifier: String
    
    /// The name of the venue.
    public let name: String
    
    /// An URL to the image of the venue.
    public let imageURL: URL?
    
    /// The rating of the venue, on a scale of 1.0 to 10.0.
    public let rating: Double
    
    /// The color of the venue's rating.
    public let ratingColor: UIColor
    
    /// The distance to the venue, in meters.
    public let distance: Double?
    
    /// The category related to the venue.
    public let category: String?
    
    /// The URL to the venue on a remote website.
    public let url: URL
    
}

/// Alias describing an array of venues.
public typealias Venues = [Venue]
