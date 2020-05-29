//
//  ProjectCollectionViewCell.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var name: String? {
        get { nameLabel.text }
        set { nameLabel.text = newValue }
    }
    
    var heroImage: UIImage? {
        get { heroImageView.image }
        set { heroImageView.image = newValue }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var heroImageView: UIImageView!
}
