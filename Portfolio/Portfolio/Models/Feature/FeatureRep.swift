//
//  Feature.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/26/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

struct FeatureRep: Codable {
    let name: String
    let id: UUID
    let mediaURL: String
    let mediaAspectRatio: Double?
    let description: String
    let codeSnippetURL: String?
}
