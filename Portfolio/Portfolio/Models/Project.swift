//
//  Project.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/26/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

class Project {
    var heroImageURL: URL
    var summary: String
    var role: String
    var technologies: [String]
    var appStoreLink: URL?
    var features: [Feature]
    
    init(heroImageURL: URL, summary: String, role: String, technologies: [String], appStoreLink: URL? = nil, features: [Feature]) {
        self.heroImageURL = heroImageURL
        self.summary = summary
        self.role = role
        self.technologies = technologies
        self.appStoreLink = appStoreLink
        self.features = features
    }
}
