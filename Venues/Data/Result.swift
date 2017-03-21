//
//  Result.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

/// Reusable enum describing the result of an operation.
public enum Result<T> {
    
    /// Indicates that the operation completed successfully.
    case success(T)
    
    /// Indicates that the operation failed with an error.
    case failure(Error)
    
}
