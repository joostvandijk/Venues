//
//  ContainerViewController.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit

/// The ContainerViewController class implements a view controller that switches between different child view controllers.
public class ContainerViewController: UIViewController {
    
    /// The view controller to display.
    public var currentViewController: UIViewController? {
        willSet {
            currentViewController?.willMove(toParentViewController: nil)
            containerViewIfLoaded?.currentView = currentViewController?.view
            currentViewController?.removeFromParentViewController()
        }
        
        didSet {
            guard let currentViewController = currentViewController else { return }
            
            addChildViewController(currentViewController)
            containerViewIfLoaded?.currentView = currentViewController.view
            currentViewController.didMove(toParentViewController: self)
            
            // Toggle the navigation bar visibility to force the controller to relayout its subviews.
            // This fixes an issue were a child view controller's scroll view wouldn't have the correct insets to avoid the navigation bar.
            navigationController?.isNavigationBarHidden = true
            navigationController?.isNavigationBarHidden = false
        }
    }
    
    // MARK: View
    
    private var containerView: ContainerView {
        return view as! ContainerView
    }
    
    private var containerViewIfLoaded: ContainerView? {
        return viewIfLoaded as? ContainerView
    }
    
    override public func loadView() {
        view = ContainerView()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.currentView = currentViewController?.view
    }
    
}

fileprivate class ContainerView: UIView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        currentView?.frame = bounds
    }
    
    /// The view to display in the container view.
    public var currentView: UIView? {
        willSet {
            currentView?.removeFromSuperview()
        }
        
        didSet {
            if let currentView = currentView {
                addSubview(currentView)
            }
        }
    }
    
}
