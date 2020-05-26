//
//  Feature.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/26/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

class Feature {
    var mediaURL: URL
    var description: String
    var codeSnippet: String
    
    init(mediaURL: URL, description: String, codeSnippet: String) {
        self.mediaURL = mediaURL
        self.description = description
        self.codeSnippet = codeSnippet
    }
}
