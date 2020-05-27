//
//  Feature.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/26/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

struct FeatureRepresentation: Codable {
    let name: String
    let id: UUID
    let mediaURL: String
    let description: String
    let codeSnippet: String?
}
