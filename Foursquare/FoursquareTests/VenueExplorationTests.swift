//
//  VenueExplorationTests.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Foursquare

class VenueExplorationTests: XCTestCase {
    
    func testUnboxing() {
        let venueExploration: VenueExploration = newModel(bundleResourceName: "venues_explore")
        XCTAssertEqual(venueExploration.location, "Doorwerth")
        XCTAssertEqual(venueExploration.groups.count, 1)
        
        let group = venueExploration.groups[0]
        XCTAssertEqual(group.name, "Recommended Places")
        XCTAssertEqual(group.items.count, 30)
        
        let item = group.items[0]
        XCTAssertEqual(item.reasons.count, 1)
        XCTAssertEqual(item.reasons[0].description, "This spot is popular")
        XCTAssertEqual(item.tips.count, 1)
        XCTAssertEqual(item.tips[0].text, "Doorwert castle nice to walk around")
    }
    
    func testRequest() {
        let location = CLLocation(latitude: 51.983325, longitude: 5.904564)
        let request = VenueExploration.request(near: location, offset: 20)
        XCTAssertEqual(request.path, "venues/explore")
        XCTAssertEqual(request.urlParameters?["ll"], "51.983325,5.904564")
        XCTAssertEqual(request.urlParameters?["offset"], "20")
    }
    
}
