//
//  Project+CoreDataProperties.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var appStoreLink: String?
    @NSManaged public var heroImageURL: String
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var role: String
    @NSManaged public var summary: String
    @NSManaged public var technologies: [NSString]
    @NSManaged public var features: NSSet

}

// MARK: Generated accessors for features

extension Project {

    @objc(addFeaturesObject:)
    @NSManaged public func addToFeatures(_ value: Feature)

    @objc(removeFeaturesObject:)
    @NSManaged public func removeFromFeatures(_ value: Feature)

    @objc(addFeatures:)
    @NSManaged public func addToFeatures(_ values: NSSet)

    @objc(removeFeatures:)
    @NSManaged public func removeFromFeatures(_ values: NSSet)

}
