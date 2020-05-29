//
//  SyncEngine.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation
import CoreData

class SyncEngine {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func syncProjects() {
        networkClient.fetchAllProjects { result in
            switch result {
            case .failure(let error):
                print("⚠️ Error fetching all projects: \(error)")
            case .success(let projectReps):
                do {
                    try self.updateProjects(with: projectReps)
                } catch {
                    print("⚠️ Error updating projects: \(error)")
                }
            }
        }
    }
    
    private func updateProjects(with projectReps: [ProjectRep]) throws {
        let identifiers = projectReps.map { $0.id }
        let repsByID = Dictionary(uniqueKeysWithValues: zip(identifiers, projectReps))
        
        let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", identifiers)
        let context = CoreDataStack.shared.container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        context.performAndWait {
            do {
                let existingProjects = try context.fetch(fetchRequest)
                var projectsToCreate = repsByID
                
                for project in existingProjects {
                    let id = project.id
                    guard let representation = repsByID[id] else { continue }
                    update(project, with: representation, in: context)
                    projectsToCreate.removeValue(forKey: id)
                }

                for representation in projectsToCreate.values {
                    Project(representation: representation, context: context)
                }
            } catch {
                print("Error fetching tasks to sync: \(error)")
            }
        }
        
        try CoreDataStack.shared.save(context: context)
    }

    private func update(_ project: Project, with representation: ProjectRep, in context: NSManagedObjectContext) {
        
        project.name = representation.name
        project.id = representation.id
        project.heroImageURL = representation.heroImageURL
        project.summary = representation.summary
        project.role = representation.role
        project.technologies = representation.technologies as [NSString]
        project.appStoreLink = representation.appStoreLink
        
        for feature in project.featuresArray {
            context.delete(feature)
        }
        
        let featureArray = representation.features
            .map { Feature(representation: $0, project: project, context: context) }
        project.addToFeatures(Set(featureArray) as NSSet)
    }
}
