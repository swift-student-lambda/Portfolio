//
//  FeatureCollectionViewCell.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit
import AVFoundation

class FeatureCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var feature: Feature? { didSet { updateViews() }}
    var seeCodeAction: ((URL) -> Void)?
    
    // MARK: - Private Properties
    
    private var loadImageOperation: LoadImageOperation?
    
    // MARK: - IBOutlets
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var videoPlayerView: VideoPlayerView!
    @IBOutlet var seeCodeButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Public Methods
    
    func loadMedia(with url: URL) {
        if url.pathExtension.isImageExtension {
            loadImageOperation = LoadImageOperation(url: url, imageView: imageView)
        } else if url.pathExtension.isVideoExtension {
            //            videoPlayerView.isHidden = false
            //            videoPlayer = AVPlayer(url: url)
            //            videoPlayerView.player = videoPlayer
            //            videoPlayer?.play()
        }
    }
    
    // MARK: - Private Methods
    
    private func updateViews() {
        guard let feature = feature else { return }
        nameLabel.text = feature.name
        descriptionLabel.text = feature.descriptionText
    }
    
    private var videoPlayer: AVPlayer?

    override func prepareForReuse() {
        loadImageOperation?.cancel()
        loadImageOperation = nil
    }
    
    // MARK: - IBActions
    
    @IBAction func seeCodeButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .systemGray2
        }
    }

    @IBAction func seeCodeButtonTouchUpInside(_ sender: UIButton) {
        if let urlString = feature?.codeSnippet, let url = URL(string: urlString) {
            seeCodeAction?(url)
        }
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .systemGray5
        }
        
        
    }
    
    @IBAction func seeCodeButtonTouchCancel(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .systemGray5
        }
    }
}

extension String {
    var isImageExtension: Bool {
        ["jpg", "jpeg", "png", "gif"].contains(self)
    }
    var isVideoExtension: Bool {
        ["mov", "mp4", "m4v"].contains(self)
    }
}
