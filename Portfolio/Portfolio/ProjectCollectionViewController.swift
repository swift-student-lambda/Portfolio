//
//  ProjectCollectionViewController.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import CoreData
import UIKit

class ProjectCollectionViewController: UICollectionViewController {
    
    private let networkClient = NetworkClient()
    private lazy var syncEngine = SyncEngine(networkClient: networkClient)
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Project> = {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        request.sortDescriptors = [
            .init(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:))),
        ]
        let context = CoreDataStack.shared.mainContext
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try? frc.performFetch()
        
        return frc
    }()
    
    private var collectionViewWidth: CGFloat {
        collectionView.frame.width - collectionView.safeAreaInsets.left - collectionView.safeAreaInsets.right
    }
    
    private var cellSize = CGSize()

    override func viewDidLoad() {
        super.viewDidLoad()
        syncEngine.syncProjects()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let projectDetailVC = segue.destination as? ProjectDetailCollectionViewController,
            let indexPath = collectionView.indexPathsForSelectedItems?.first {
            projectDetailVC.project = fetchedResultsController.object(at: indexPath)
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        fetchedResultsController.sections?.count ?? 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ProjectCell",
            for: indexPath) as? ProjectCollectionViewCell else {
                fatalError("Unable to cast cell as \(ProjectCollectionViewCell.self)")
        }
    
        let project = fetchedResultsController.object(at: indexPath)
        
        cell.nameLabel.text = project.name
        
        if let url = URL(string: project.heroImageURL) {
            networkClient.fetchImage(url: url) { (result) in
                switch result {
                case .failure(let error):
                    print("⚠️ There was an error fetching an image for \(url): \(error)")
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.heroImageView.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    // MARK: - Scroll View Delegate - Paging
    
    private var targetPage = 0
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Set target page to current page initially
        targetPage = Int((scrollView.contentOffset.x / cellSize.width).rounded())
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // Use velocity to determine target page
        if velocity.x > 0 {
            targetPage += 1
        } else if velocity.x < 0 {
            targetPage -= 1
        } else {
            // If no velocity, go to closest page
            targetPage = Int((scrollView.contentOffset.x / cellSize.width).rounded())
        }
        
        // Only animate to the target page if it is valid, otherwise just bounce
        if targetPage >= 0 && targetPage < collectionView.numberOfItems(inSection: 0) {
            let targetPageOffset = CGFloat(targetPage) * cellSize.width
            scrollView.setContentOffset(.init(x: targetPageOffset, y: 0), animated: true)
            targetContentOffset.pointee = CGPoint(x: scrollView.contentOffset.x, y: 0)
        }
    }
}

// MARK: - Flow Layout Delegate

extension ProjectCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - collectionView.safeAreaInsets.bottom - collectionView.safeAreaInsets.top
        let width = collectionView.frame.width - collectionView.safeAreaInsets.left - collectionView.safeAreaInsets.right
        
        cellSize = CGSize(width: width * 0.8, height: height)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let width = collectionView.frame.width - collectionView.safeAreaInsets.left - collectionView.safeAreaInsets.right
        
        return width * 0.2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = collectionView.frame.width - collectionView.safeAreaInsets.left - collectionView.safeAreaInsets.right
        return .init(top: 0, left: width * 0.1, bottom: 0, right: width * 0.1)
    }
}

// MARK: - Fetched Results Controller Delegate

extension ProjectCollectionViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        collectionView.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        collectionView.reloadData()
    }
}
