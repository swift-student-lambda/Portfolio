//
//  Feature+CoreDataProperties.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//
//

import Foundation
import CoreData


extension Feature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feature> {
        NSFetchRequest<Feature>(entityName: "Feature")
    }

    @NSManaged public var codeSnippet: String?
    @NSManaged public var descriptionText: String
    @NSManaged public var id: UUID
    @NSManaged public var mediaURL: String
    @NSManaged public var name: String
    @NSManaged public var project: Project

}
