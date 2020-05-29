//
//  Feature+Convenience.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import CoreData
import Foundation

extension Feature {
    var representation: FeatureRep {
        FeatureRep(
            name: name,
            id: id,
            mediaURL: mediaURL,
            mediaAspectRatio: mediaAspectRatio?.doubleValue,
            description: descriptionText,
            codeSnippetURL: codeSnippetURL
        )
    }
    
    @discardableResult
    convenience init(representation: FeatureRep, project: Project, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = representation.name
        self.id = representation.id
        self.mediaURL = representation.mediaURL
        if let mediaAspectRatio = representation.mediaAspectRatio {
            self.mediaAspectRatio = NSNumber(value: mediaAspectRatio)
        }
        self.descriptionText = representation.description
        self.codeSnippetURL = representation.codeSnippetURL
        self.project = project
    }
}
