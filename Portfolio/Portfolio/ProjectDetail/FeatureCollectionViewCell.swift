//
//  FeatureCollectionViewCell.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class FeatureCollectionViewCell: UICollectionViewCell {
    
    var feature: Feature? { didSet { updateViews() }}
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var seeCodeButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    
    private var loadImageOperation: LoadImageOperation?
    
    func updateViews() {
        guard let feature = feature else { return }
        nameLabel.text = feature.name
        
        if let url = URL(string: feature.mediaURL) {
             loadImageOperation = LoadImageOperation(url: url, imageView: imageView)
        }

        descriptionLabel.text = feature.descriptionText
    }
    
    
    override func prepareForReuse() {
        loadImageOperation?.cancel()
        loadImageOperation = nil
    }

}
