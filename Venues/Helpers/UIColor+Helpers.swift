//
//  UIColor+Helpers.swift
//  Venues
//
//  Created by Joost van Dijk on 22/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// Creates and returns a color interpolated between the receiver and the given color.
    ///
    /// Note: Only works with colors convertable to the RGBA color space. Will return the receiver for incompatible color spaces.
    ///
    /// - Parameters:
    ///   - color: The color to interpolate to.
    ///   - location: The location to interpolate to. Must be a value in a range of 0.0 to 1.0.
    public func interpolate(to color: UIColor, _ location: CGFloat) -> UIColor {
        assert(location >= 0.0 && location <= 1.0, "Location must be in range of 0.0 to 1.0.")
        
        guard let currentComponents = rgbaComponents, let targetComponents = color.rgbaComponents else {
            return self
        }
        
        let red = currentComponents.red + (targetComponents.red - currentComponents.red) * location
        let green = currentComponents.green + (targetComponents.green - currentComponents.green) * location
        let blue = currentComponents.blue + (targetComponents.blue - currentComponents.blue) * location
        let alpha = currentComponents.alpha + (targetComponents.alpha - currentComponents.alpha) * location
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Returns a tuble with the RGBA components of the receiver, or nil if the receiver couldn't be converted to the RGBA color space.
    public var rgbaComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        return (red, green, blue, alpha)
    }
    
}
