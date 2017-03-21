//
//  Response.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

/// Structure describing a successful response from the Foursquare backend.
public struct Response<DataType: Unboxable>: Unboxable {
    
    /// The identifier of the request that was performed.
    public let identifier: String
    
    /// The status code as returned by the Foursquare backend.
    public let statusCode: Int
    
    /// The body returned in the response.
    public let data: DataType
    
    /// Initializes the response.
    ///
    /// - Parameter unboxer: The unboxer to use for retrieving the values.
    /// - Throws: An UnboxError in case an unrecoverable error occurrs.
    public init(unboxer: Unboxer) throws {
        identifier = try unboxer.unbox(keyPath: "meta.requestId")
        statusCode = try unboxer.unbox(keyPath: "meta.code")
        data = try unboxer.unbox(key: "response")
    }
    
}
