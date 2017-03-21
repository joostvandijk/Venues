//
//  NetworkImageView.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit

/// The NetworkImageView class displays an image from a remote location.
public class NetworkImageView: UIImageView {
    
    /// The URL to the image to display.
    public var imageURL: URL? {
        didSet {
            clearImage()
            
            if let imageURL = imageURL {
                loadImage(url: imageURL)
            }
        }
    }
    
    private func clearImage() {
        image = nil
        
        currentImageTask?.cancel()
        currentImageTask = nil
    }
    
    private func loadImage(url: URL) {
        currentImageTask = URLSession.shared.dataTask(with: url) { [unowned self] (data, _, _) in
            self.currentImageTask = nil
            
            guard let data = data else {
                return
            }
            
            guard let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        currentImageTask?.resume()
    }
    
    private var currentImageTask: URLSessionDataTask?
    
}
