//
//  VenueTests.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import XCTest
@testable import Foursquare

class VenueTests: XCTestCase {
    
    func testUnboxing() {
        let venue: Venue = newModel(bundleResourceName: "venue")
        XCTAssertEqual(venue.identifier, "4bc9e90f937ca5939993a692")
        XCTAssertEqual(venue.name, "De Oude Herbergh")
        XCTAssertEqualWithAccuracy(venue.rating, 7.8, accuracy: 0.00001)
        XCTAssertEqual(venue.categories.count, 1)
        XCTAssertEqual(venue.featuredPhotos.count, 1)
        XCTAssertEqual(venue.url, URL(string: "https://foursquare.com/v/4bc9e90f937ca5939993a692"))
        
        let location = venue.location
        XCTAssertEqual(location.address, "Utrechtseweg 245")
        XCTAssertEqual(location.postalCode, "6862 AK")
        XCTAssertEqual(location.city, "Oosterbeek")
        XCTAssertEqual(location.state, "Gelderland")
        XCTAssertEqual(location.country, "Nederland")
        XCTAssertEqual(location.distance, 1980)
        
        let category = venue.categories.first!
        XCTAssertEqual(category.identifier, "4bf58dd8d48988d1c4941735")
        XCTAssertEqual(category.name, "Restaurant")
        XCTAssertEqual(category.shortName, "Restaurant")
        XCTAssertEqual(category.pluralName, "Restaurants")
        
        let featuredPhoto = venue.featuredPhotos.first!
        XCTAssertEqual(featuredPhoto.identifier, "588238f3ca10705c93d64d63")
        XCTAssertEqual(featuredPhoto.size.width, 1440.0)
        XCTAssertEqual(featuredPhoto.size.height, 1920.0)
        XCTAssertEqual(featuredPhoto.prefix, "https://igx.4sqi.net/img/general/")
        XCTAssertEqual(featuredPhoto.suffix, "/57214473_cKL9V8yTcZO6FuKVTYdMXD4nwz1E08Wu7C3RlcgJU4I.jpg")
    }
    
}
