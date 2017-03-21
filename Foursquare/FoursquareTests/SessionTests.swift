//
//  SessionTests.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import XCTest
@testable import Foursquare

class SessionTests: XCTestCase {
    
    func testConstructingURL() {
        let request = Request<VenueExploration>(path: "venues/explore",
                                                urlParameters: ["param1": "value1",
                                                                "param2": "value2"])
        
        let url = sampleSession.url(for: request)!
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "api.foursquare.com")
        XCTAssertEqual(url.path, "/v2/venues/explore")
        
        let query = url.query!
        XCTAssertTrue(query.contains("param1=value1"))
        XCTAssertTrue(query.contains("param2=value2"))
        XCTAssertTrue(query.contains("client_id=test_client_id"))
        XCTAssertTrue(query.contains("client_secret=test_client_secret"))
        XCTAssertTrue(query.contains("v=20170320"))
    }

    // MARK: Helpers
    
    private var sampleSession: Session {
        let configuration = Session.Configuration(clientIdentifier: "test_client_id",
                                                  clientSecret: "test_client_secret")
        
        return Session(configuration: configuration)
    }
    
}
