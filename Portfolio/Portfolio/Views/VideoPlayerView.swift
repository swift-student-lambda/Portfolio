//
//  VideoPlayerView.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/28/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import AVFoundation
import UIKit

class VideoPlayerView: UIView {
    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }
    var videoPlayerLayer: AVPlayerLayer {
        guard let layer = layer as? AVPlayerLayer else {
            fatalError("Layer not expected type of \(AVPlayerLayer.self)")
        }
        return layer
    }
    var player: AVPlayer? {
        get { videoPlayerLayer.player }
        set { videoPlayerLayer.player = newValue }
    }
}
