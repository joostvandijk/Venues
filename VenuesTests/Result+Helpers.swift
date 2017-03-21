//
//  Result+Helpers.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation
@testable import Venues

extension Result {
    var isSuccess: Bool {
        switch self {
        case .success(_):
            return true
        default:
            return false
        }
    }
    
    var isFailure: Bool {
        switch self {
        case .failure(_):
            return true
        default:
            return false
        }
    }
    
    var data: T? {
        switch self {
        case let .success(data):
            return data
        default:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case let .failure(error):
            return error
        default:
            return nil
        }
    }
}
