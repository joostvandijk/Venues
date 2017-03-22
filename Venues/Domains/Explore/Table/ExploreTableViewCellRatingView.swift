//
//  ExploreTableViewCellRatingView.swift
//  Venues
//
//  Created by Joost van Dijk on 22/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit

/// The ExploreTableViewCellRatingView class implements a view that displays a venue's rating.
public class ExploreTableViewCellRatingView: UIView {
    
    public init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.clear
        contentMode = .redraw
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Rating
    
    /// The rating to display.
    public var rating: Double? {
        didSet {
            if let rating = rating {
                attributedString = newAttributedString(rating: rating)
            } else {
                attributedString = nil
            }
            
            setNeedsDisplay()
        }
    }
    
    private var attributedString: NSAttributedString?
    
    private func newAttributedString(rating: Double) -> NSAttributedString {
        let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17.0),
                          NSForegroundColorAttributeName: UIColor.white]
        
        return NSAttributedString(string: String(rating), attributes: attributes)
    }
    
    private var fillColor: UIColor? {
        guard let rating = rating else {
            return nil
        }
        
        let scaledRating = min(max(CGFloat(rating) - 5.0, 0.0), 5.0)
        let location = scaledRating / 5.0
        
        return UIColor.red.interpolate(to: UIColor.green, location)
    }
    
    // MARK: Layout
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let attributedString = attributedString else {
            return .zero
        }
        
        var calculatedSize = attributedString.boundingRect(with: size, options: [], context: nil).size
        calculatedSize.width = insets.left + ceil(calculatedSize.width) + insets.right
        calculatedSize.height = insets.top + ceil(calculatedSize.height) + insets.bottom
        
        return calculatedSize
    }
    
    public override func sizeToFit() {
        let constrainedSize = CGSize(width: CGFloat.greatestFiniteMagnitude,
                                     height: CGFloat.greatestFiniteMagnitude)
        
        var frame = self.frame
        frame.size = sizeThatFits(constrainedSize)
        self.frame = frame
    }
    
    private let insets = UIEdgeInsets(top: 2.0, left: 5.0, bottom: 2.0, right: 5.0)
    
    // MARK: Drawing
    
    override public func draw(_ rect: CGRect) {
        // Clear the background.
        UIColor.clear.setFill()
        UIRectFill(rect)
        
        guard let attributedString = self.attributedString, let fillColor = fillColor else {
            return
        }
        
        // Draw the shape.
        fillColor.setFill()
        UIBezierPath(roundedRect: rect, cornerRadius: 3.0).fill()
        
        // Draw the text.
        attributedString.draw(at: CGPoint(x: insets.left, y: insets.top))
    }
    
}
