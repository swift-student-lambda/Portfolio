//
//  String+MediaExtensions.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/29/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

extension String {
    var isImageExtension: Bool {
        ["jpg", "jpeg", "png", "gif"].contains(self)
    }
    var isVideoExtension: Bool {
        ["mov", "mp4", "mpeg-4", "m4v", "avi"].contains(self)
    }
}
