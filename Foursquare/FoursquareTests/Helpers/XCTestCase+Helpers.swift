//
//  XCTestCase+Helpers.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import XCTest
@testable import Foursquare

public extension XCTestCase {
    
    /// Unboxes a resource from the current bundle into a model. Will throw an assertion when the resource can't be found or unboxed.
    ///
    /// - Parameter bundleResourceName: The name of the resource to unbox in the current bundle.
    /// - Returns: An unboxed bundle resource.
    public func newModel<Model: Unboxable>(bundleResourceName: String) -> Model {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: bundleResourceName, withExtension: "json") else {
            fatalError("Couldn't find resource with name '\(bundleResourceName)'.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Couldn't read data for resource with name '\(bundleResourceName)'.")
        }
        
        do {
            return try unbox(data: data) as Model
        } catch {
            fatalError("Couldn't unbox resource with name '\(bundleResourceName)' (error: \(error)).")
        }
    }
    
}
