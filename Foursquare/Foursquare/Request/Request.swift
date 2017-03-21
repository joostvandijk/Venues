//
//  Request.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

/// Structure describing a request which can be made to the Foursquare backend.
public struct Request<DataType: Unboxable> {
    
    /// The path of the request. Will be resolved against the base URL.
    internal let path: String
    
    /// The parameters to embed in the request's URL.
    internal let urlParameters: URLParameters?
    
    /// Initializes the request.
    ///
    /// - Parameters:
    ///   - path: The path of the request.
    ///   - urlParameters: The parameters to embed in the request's URL.
    internal init(path: String, urlParameters: URLParameters? = nil) {
        self.path = path
        self.urlParameters = urlParameters
    }
    
    /// Alias for URL parameters.
    internal typealias URLParameters = [String: String]
    
}
