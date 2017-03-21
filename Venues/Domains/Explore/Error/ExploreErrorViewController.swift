//
//  ExploreErrorViewController.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit

/// The ExploreErrorViewController provides a view controller to display an error.
public class ExploreErrorViewController: UIViewController {
    
    /// The error to display.
    public let error: Error
    
    /// Initializes the error view controller.
    ///
    /// - Parameter error: The error to display.
    public init(error: Error) {
        self.error = error
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    
    override public func loadView() {
        view = ExploreErrorView()
    }
    
}

fileprivate class ExploreErrorView: UIView {
    
    public init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.white
        
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        var labelFrame = CGRect.zero
        labelFrame.size = label.sizeThatFits(bounds.insetBy(dx: 80.0, dy: 80.0).size)
        labelFrame.origin.x = round(bounds.midX - labelFrame.size.width / 2.0)
        labelFrame.origin.y = round(bounds.midY - labelFrame.size.height / 2.0)
        label.frame = labelFrame
    }
    
    // MARK: Label
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = self.newLabelAttributedText(title: "Oops!", subtitle: "An error occurred.")
        
        return label
    }()
    
    private func newLabelAttributedText(title: String, subtitle: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let titleAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17.0),
                               NSParagraphStyleAttributeName: paragraphStyle]
        let subtitleAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17.0),
                                  NSParagraphStyleAttributeName: paragraphStyle]
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: title + "\n", attributes: titleAttributes))
        attributedString.append(NSAttributedString(string: subtitle, attributes: subtitleAttributes))
        
        return attributedString
    }
    
}
