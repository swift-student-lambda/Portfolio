//
//  Project.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/26/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation
import SSNetworking

struct ProjectRep: Codable {
    let name: String
    let id: UUID
    let heroImageURL: String
    let summary: String
    let role: String
    let technologies: [String]
    let appStoreLink: String?
    let features: [FeatureRep]
}

struct ProjectRepDecoder: ResultDecoder {
    typealias ResultType = [ProjectRep]
}
