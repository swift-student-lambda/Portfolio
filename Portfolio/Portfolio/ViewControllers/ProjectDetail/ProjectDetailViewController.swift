//
//  ProjectDetailViewController.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit
import WebKit

private let cellID = "FeatureCell"
private let headerID = "ProjectDetailHeaderView"

class ProjectDetailViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var project: Project?
    
    // MARK: - Private Properties
    
    @IBOutlet private var collectionView: UICollectionView!
    
    // swiftlint:disable force_cast
    private lazy var sizingCell = Bundle.main.loadNibNamed("FeatureCollectionViewCell",
                                                           owner: self,
                                                           options: nil)?.first as! FeatureCollectionViewCell
    private lazy var sizingHeader = Bundle.main.loadNibNamed("ProjectDetailHeaderView",
                                                             owner: self,
                                                             options: nil)?.first as! ProjectDetailHeaderView
    // swiftlint:enable force_cast
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UINib(nibName: "FeatureCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: cellID)
        self.collectionView!.register(UINib(nibName: "ProjectDetailHeaderView", bundle: .main),
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                      withReuseIdentifier: headerID)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - IBActions
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: UICollectionViewDataSource

extension ProjectDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        project?.featuresArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellID,
            for: indexPath) as? FeatureCollectionViewCell else {
                fatalError("Unable to cast cell as \(FeatureCollectionViewCell.self)")
        }
        
        
        let feature = project?.featuresArray[indexPath.row]
        cell.feature = feature
        
        if let urlString = feature?.mediaURL, let url = URL(string: urlString) {
            cell.loadMedia(with: url)
        }
        
        cell.seeCodeAction = { [weak self] url in
            guard let self = self else { return }
            guard let codeVC = UIStoryboard(name: "Main", bundle: .main)
                .instantiateViewController(withIdentifier: "CodeViewController") as? CodeViewController else {
                    return
            }
            codeVC.url = url
            self.present(codeVC, animated: true, completion: nil)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerID,
            for: indexPath) as? ProjectDetailHeaderView else {
                fatalError("Unable to cast header as \(ProjectDetailHeaderView.self)")
        }
        
        header.project = project
        
        return header
    }
}

// MARK: - Flow Layout Delegate

extension ProjectDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizingCell.feature = project?.featuresArray[indexPath.item]
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        var cellSize = sizingCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        cellSize.width = collectionView.frame.width
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        sizingHeader.project = project
        sizingHeader.setNeedsLayout()
        sizingHeader.layoutIfNeeded()
        var headerSize = sizingHeader.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        headerSize.height += 20
        return headerSize
    }
}
