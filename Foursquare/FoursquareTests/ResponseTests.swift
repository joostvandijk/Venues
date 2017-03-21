//
//  ResponseTests.swift
//  Foursquare
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import XCTest
@testable import Foursquare

class ResponseTests: XCTestCase {
    
    func testUnboxing() {
        let response: Response<VenueExploration> = newModel(bundleResourceName: "response")
        XCTAssertEqual(response.identifier, "58d03c299fb6b777d21d2483")
        XCTAssertEqual(response.statusCode, 200)
    }
    
}
