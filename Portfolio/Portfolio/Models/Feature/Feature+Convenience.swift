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
            description: descriptionText,
            codeSnippet: codeSnippet
        )
    }
    
    @discardableResult
    convenience init(representation: FeatureRep, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = representation.name
        self.id = representation.id
        self.mediaURL = representation.mediaURL
        self.descriptionText = representation.description
        self.codeSnippet = representation.codeSnippet
    }
}
