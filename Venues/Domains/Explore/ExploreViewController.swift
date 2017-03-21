//
//  ExploreViewController.swift
//  Venues
//
//  Created by Joost van Dijk on 18/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit
import Foursquare
import SafariServices

/// The ExploreViewController class provides a view controller to browse through nearby venues.
public class ExploreViewController: ContainerViewController {
    
    public init(venueService: VenueService, userLocationService: UserLocationService) {
        nearbyVenueSearchController = NearbyVenueSearchController(venueService: venueService,
                                                                  userLocationService: userLocationService)
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Explore"
        currentViewController = ExploreLoadingViewController()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        requestNearbyVenues()
    }
    
    // MARK: Nearby Venue Search Controller
    
    private let nearbyVenueSearchController: NearbyVenueSearchController
    
    private func requestNearbyVenues() {
        nearbyVenueSearchController.requestNearbyVenues { result in
            DispatchQueue.main.async {
                self.handleNearbyVenueRequestResult(result)
            }
        }
    }
    
    private func handleNearbyVenueRequestResult(_ result: Result<Venues>) {
        switch result {
        case let .success(venues):
            currentViewController = ExploreTableViewController(venues: venues, delegate: self)
        case let .failure(error):
            currentViewController = ExploreErrorViewController(error: error)
        }
    }
    
}

// MARK: Table View Controller Delegate

extension ExploreViewController: ExploreTableViewControllerDelegate {
    public func didSelect(_ venue: Venue, in exploreTableViewController: ExploreTableViewController) {
        let safariViewController = SFSafariViewController(url: venue.url)
        present(safariViewController, animated: true, completion: nil)
    }
}
