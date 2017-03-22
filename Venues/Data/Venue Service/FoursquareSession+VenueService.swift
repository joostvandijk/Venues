//
//  FoursquareSession+VenueService.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation
import Foursquare
import CoreLocation

extension Foursquare.Session: VenueService {
    
    /// Requests venues near a given location.
    ///
    /// - Parameters:
    ///   - location: The location to search for nearby venues.
    ///   - offset: The offset of the returned venues, used to paginate to a new set of venues.
    ///   - completionHandler: The completion handler to invoke when the
    public func requestVenues(near location: CLLocation, offset: Int?, completionHandler: @escaping VenueService.CompletionHandler<Venues>) {
        let request = VenueExploration.request(near: location, offset: offset)
        perform(request) { result in
            switch result {
            case let .success(response):
                completionHandler(.success(response.data.allVenues))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

fileprivate extension VenueExploration {
    
    /// Maps the venue exploration's groups and items into single venue structures.
    fileprivate var allVenues: Venues {
        let venues = groups.map { group -> Venues in
            return group.items.map { Venue(item: $0) }
        }.joined()
        
        return Array(venues)
    }
    
}

fileprivate extension Venue {
    fileprivate init(item: VenueExploration.Item) {
        identifier = item.venue.identifier
        name = item.venue.name
        rating = item.venue.rating
        distance = item.venue.location.distance
        category = item.venue.categories.first?.name
        url = item.venue.url
        
        if let featuredPhoto = item.venue.featuredPhotos.first {
            imageURL = URL(string: featuredPhoto.prefix + "500x500" + featuredPhoto.suffix)
        } else {
            imageURL = nil
        }
    }
}
