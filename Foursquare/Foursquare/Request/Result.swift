//
//  Result.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

/// Enum describing the different results that occur after performing a request.
public enum Result<DataType: Unboxable> {
    
    /// Indicates that the request has been completed successfully.
    case success(Response<DataType>)
    
    /// Indicates that the request couldn't be completed.
    case failure(Error)
    
}
