//
//  Project+Convenience.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import CoreData
import Foundation

extension Project {
    var featuresArray: [Feature] {
        let set = features as? Set<Feature> ?? []
        return set.sorted { $0.name < $1.name }
    }
    
    var representation: ProjectRep {
        ProjectRep(
            name: name,
            id: id,
            heroImageURL: heroImageURL,
            summary: summary,
            role: role,
            technologies: technologies.map { String($0) },
            appStoreLink: appStoreLink,
            features: featuresArray.map { $0.representation }
        )
    }
    
    @discardableResult
    convenience init(representation: ProjectRep, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = representation.name
        self.id = representation.id
        self.heroImageURL = representation.heroImageURL
        self.summary = representation.summary
        self.role = representation.role
        self.technologies = representation.technologies as [NSString]
        self.appStoreLink = representation.appStoreLink
        let featureArray = representation.features.map { Feature(representation: $0, project: self, context: context) }
        self.features = Set(featureArray) as NSSet
    }
}


