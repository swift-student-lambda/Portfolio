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
    
    var feature: Feature? { didSet { updateViews() } }
    var seeCodeAction: ((URL) -> Void)?
    
    // MARK: - Private Properties
    
    private var loadImageOperation: LoadImageOperation?
    private var loadVideoOperation: LoadVideoOperation?
    private var videoPlayer: AVPlayer?
    
    // MARK: - IBOutlets
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var videoPlayerView: VideoPlayerView!
    @IBOutlet private var seeCodeButton: UIButton!
    @IBOutlet private var descriptionLabel: UILabel!
    
    // MARK: - Public Methods
    
    func loadMedia(with url: URL) {
        if url.pathExtension.isImageExtension {
            self.videoPlayerView.isHidden = true
            loadImageOperation = LoadImageOperation(url: url, imageView: imageView)
        } else if url.pathExtension.isVideoExtension {
            loadVideoOperation = LoadVideoOperation(url: url, callback: { [weak self] fileURL in
                guard let fileURL = fileURL, let self = self else { return }
                self.startVideoPlayer(with: fileURL)
            })
        }
    }
    
    // MARK: - Private Methods
    
    func startVideoPlayer(with url: URL) {
        videoPlayerView.isHidden = false
        videoPlayer = AVPlayer(url: url)
        videoPlayerView.player = self.videoPlayer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.videoFinishedPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )
        videoPlayer?.play()
    }
    
    @objc private func videoFinishedPlaying() {
        videoPlayer?.seek(to: .zero)
        videoPlayer?.play()
    }
    
    private func updateViews() {
        guard let feature = feature else { return }
        nameLabel.text = feature.name
        descriptionLabel.text = feature.descriptionText
    }

    override func prepareForReuse() {
        loadImageOperation?.cancel()
        loadVideoOperation?.cancel()
        super.prepareForReuse()
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
