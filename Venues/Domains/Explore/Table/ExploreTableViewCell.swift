//
//  ExploreTableViewCell.swift
//  Venues
//
//  Created by Joost van Dijk on 21/03/2017.
//  Copyright © 2017 JWVD. All rights reserved.
//

import UIKit

/// The ExploreTableViewCell implements a cell in a table view to display a venue's data.
public class ExploreTableViewCell: UITableViewCell {
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(networkImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        configureConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        data = nil
    }
    
    // MARK: Data
    
    /// Structure describing the data that fills the cell.
    public struct Data {
        
        /// The URL to the image to display.
        public let imageURL: URL?
        
        /// The name to display.
        public let name: String
        
        /// The category to display.
        public let category: String?
        
        /// The distance to display.
        public let distance: String?
        
        /// The tip to display.
        public let tip: String?
        
    }
    
    /// The data to fill the cell with.
    public var data: Data? {
        didSet {
            if let data = data {
                networkImageView.imageURL = data.imageURL
                titleLabel.attributedText = newTitleLabelAttributedText(data: data)
                subtitleLabel.text = data.tip
            } else {
                networkImageView.imageURL = nil
                titleLabel.text = nil
                subtitleLabel.text = nil
            }
        }
    }
    
    // MARK: Layout
    
    private func configureConstraints() {
        let marginsGuide = contentView.layoutMarginsGuide
        let spacing = layoutMargins.left
        
        let constraints = [networkImageView.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
                           networkImageView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
                           networkImageView.widthAnchor.constraint(equalToConstant: 60.0),
                           networkImageView.heightAnchor.constraint(equalToConstant: 60.0),
                           titleLabel.centerYAnchor.constraint(equalTo: networkImageView.centerYAnchor),
                           titleLabel.leadingAnchor.constraint(equalTo: networkImageView.trailingAnchor, constant: spacing),
                           titleLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
                           subtitleLabel.topAnchor.constraint(equalTo: networkImageView.bottomAnchor, constant: spacing),
                           subtitleLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
                           subtitleLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
                           subtitleLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Network Image View
    
    private lazy var networkImageView: NetworkImageView = {
        let networkImageView = NetworkImageView()
        networkImageView.contentMode = .scaleAspectFill
        networkImageView.backgroundColor = UIColor.lightGray
        networkImageView.clipsToBounds = true
        networkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        networkImageView.layer.cornerRadius = 3.0
        
        return networkImageView
    }()
    
    // MARK: Title Label
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private func newTitleLabelAttributedText(data: Data) -> NSAttributedString {
        let nameAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17.0)]
        let categoryAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0),
                                  NSForegroundColorAttributeName: UIColor.gray]
        let distanceAttributes = categoryAttributes
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: data.name + "\n", attributes: nameAttributes))
        
        if let category = data.category {
            attributedString.append(NSAttributedString(string: category + "\n", attributes: categoryAttributes))
        }
        
        if let distance = data.distance {
            attributedString.append(NSAttributedString(string: distance, attributes: distanceAttributes))
        }
        
        return attributedString
    }
    
    // MARK: Subtitle Label
    
    private lazy var subtitleLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 14.0)
        tipLabel.numberOfLines = 0
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return tipLabel
    }()
    
}
