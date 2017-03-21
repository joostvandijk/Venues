//
//  AppDelegate.swift
//  Venues
//
//  Created by Joost van Dijk on 18/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit
import Foursquare

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let exploreViewController = ExploreViewController(venueService: foursquareSession,
                                                          userLocationService: UserLocationController())
        
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: exploreViewController)
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    private lazy var foursquareSession: Foursquare.Session = {
        let configuration = Foursquare.Session.Configuration(clientIdentifier: "",
                                                             clientSecret: "")
        
        let session = Foursquare.Session(configuration: configuration)
        
        return session
    }()

}
