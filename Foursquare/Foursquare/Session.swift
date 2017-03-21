//
//  Session.swift
//  Foursquare
//
//  Created by Joost van Dijk on 20/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import Foundation

/// The Session class provides an API to communicate with Foursquare.
public class Session {
    
    /// The configuration used to initialize and configure the session.
    public let configuration: Configuration
    
    /// Initializes the session.
    ///
    /// - Parameter configuration: The configuration to initialize and configure the session with.
    public init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    // MARK: Performing Requests
    
    /// Alias for the completion handler of requests.
    public typealias CompletionHandler<DataType: Unboxable> = (Result<DataType>) -> Void
    
    /// Performs the given request and invokes the completion handler upon completion.
    ///
    /// - Parameters:
    ///   - request: The request to perform.
    ///   - comletionHandler: The completion handler to invoke when the request has been completed.
    public func perform<DataType>(_ request: Request<DataType>, completionHandler: @escaping CompletionHandler<DataType>) {
        guard let url = self.url(for: request) else {
            let error = SessionError.invalidURL
            completionHandler(.failure(error))
            
            return
        }
        
        let urlSession = URLSession.shared
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                
                return
            }
            
            guard let data = data else {
                let error = SessionError.invalidResponse
                completionHandler(.failure(error))
                
                return
            }
            
            do {
                let response: Response<DataType> = try unbox(data: data)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: URL Construction
    
    /// Creates and returns a URL for the given request.
    ///
    /// - Parameter request: The request to construct a URL for.
    /// - Returns: A URL for the given request, or nil if none could be constructed.
    internal func url<DataType>(for request: Request<DataType>) -> URL? {
        var urlParameters = request.urlParameters ?? [:]
        urlParameters["client_id"] = configuration.clientIdentifier
        urlParameters["client_secret"] = configuration.clientSecret
        urlParameters["v"] = "20170320"
        
        var urlComponents = URLComponents(string: "https://api.foursquare.com/")
        urlComponents?.path = "/v2/" + request.path
        urlComponents?.queryItems = urlParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return urlComponents?.url
    }
    
}

// MARK: Error

/// Enum specifying the different errors that can occurr whilst working with the Session class.
public enum SessionError: Error {
    
    /// Indicates that a request couldn't be performed because a valid URL couldn't be constructed.
    case invalidURL
    
    /// Indicates that an invalid response was returned from the request.
    case invalidResponse
    
}

// MARK: Configuration

public extension Session {
    
    /// The Configuration structure provides a collection of properties used to initialize and configure the Session class.
    public struct Configuration {
        
        /// The client's identifier, provided by Foursquare.
        public let clientIdentifier: String
        
        /// The client's secret, provided by Foursquare.
        public let clientSecret: String
        
        /// Initializes the configuration
        ///
        /// - Parameters:
        ///   - clientIdentifier: The client's identifier, provided by Foursquare.
        ///   - clientSecret: The client's secret, provided by Foursquare.
        public init(clientIdentifier: String, clientSecret: String) {
            self.clientIdentifier = clientIdentifier
            self.clientSecret = clientSecret
        }
        
    }
    
}
