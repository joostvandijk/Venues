//
//  ExploreLoadingViewController.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit

/// The ExploreLoadingViewController provides a view controller to indicate a loading state.
public class ExploreLoadingViewController: UIViewController {
    
    override public func loadView() {
        view = ExploreLoadingView()
    }
    
}

fileprivate class ExploreLoadingView: UIView {
    
    public init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.white
        
        addSubview(activityIndicatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        
        if window != nil {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicatorView.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    // MARK: Activity Indicator View
    
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
}
