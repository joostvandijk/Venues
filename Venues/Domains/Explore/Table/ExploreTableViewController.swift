//
//  ExploreTableViewController.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit
import MapKit

/// The ExploreTableViewController provides a view controller to display a set of venues in a table.
public class ExploreTableViewController: UIViewController {
    
    /// The venues to display.
    public let venues: Venues
    
    /// The delegate of the explore table view controller.
    public weak var delegate: ExploreTableViewControllerDelegate?
    
    /// Initializes the table view controller.
    ///
    /// - Parameters:
    ///   - venues: The venues to display.
    ///   - delegate: The delegate of the explore table view controller.
    public init(venues: Venues, delegate: ExploreTableViewControllerDelegate?) {
        self.venues = venues
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88.0
        
        tableView.register(ExploreTableViewCell.self, forCellReuseIdentifier: self.tableViewCellReuseIdentifier)
        
        return tableView
    }()
    
    fileprivate let tableViewCellReuseIdentifier = "VenueCell"
    
    override public func loadView() {
        super.loadView()
        
        view = tableView
    }
    
    // MARK: Helpers
    
    fileprivate func venue(at indexPath: IndexPath) -> Venue {
        return venues[indexPath.row]
    }
    
}

// MARK: Delegate

/// Instances conforming to the ExploreTableViewControllerDelegate protocol will be informed of user interactions with the displayed venues.
public protocol ExploreTableViewControllerDelegate: class {
    
    /// Invoked when a venue is selected.
    ///
    /// - Parameters:
    ///   - venue: The venue that has been selected.
    ///   - exploreTableViewController: The explore table view controller in which the venue has been selected.
    func didSelect(_ venue: Venue, in exploreTableViewController: ExploreTableViewController)
    
}

// MARK: Table View Data Source

extension ExploreTableViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath) as! ExploreTableViewCell
        cell.data = data(for: venue(at: indexPath))
        
        return cell
    }
    
    private func data(for venue: Venue) -> ExploreTableViewCell.Data {
        var formattedDistance: String?
        
        if let distance = venue.distance {
            let distanceFormatter = MKDistanceFormatter()
            formattedDistance = distanceFormatter.string(fromDistance: distance)
        }
        
        return ExploreTableViewCell.Data(imageURL: venue.imageURL,
                                         name: venue.name,
                                         category: venue.category,
                                         distance: formattedDistance,
                                         rating: venue.rating)
    }
    
}

// MARK: Table View Delegate

extension ExploreTableViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let venue = self.venue(at: indexPath)
        delegate?.didSelect(venue, in: self)
    }
    
}
