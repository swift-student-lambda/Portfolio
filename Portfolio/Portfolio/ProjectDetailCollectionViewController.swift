//
//  ProjectDetailCollectionViewController.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FeatureCell"
private var sizingCell = FeatureCollectionViewCell()

class ProjectDetailCollectionViewController: UICollectionViewController {
    
    var project: Project?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "FeatureCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: reuseIdentifier)
        sizingCell = Bundle.main.loadNibNamed("FeatureCollectionViewCell", owner: self, options: nil)?.first as! FeatureCollectionViewCell

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        project?.featuresArray.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? FeatureCollectionViewCell else {
                fatalError("Unable to cast cell as \(FeatureCollectionViewCell.self)")
        }
    
        cell.feature = project?.featuresArray[indexPath.row]
    
        return cell
    }

}

extension ProjectDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizingCell.feature = project?.featuresArray[indexPath.item]
//        let width = collectionView.frame.width
//        sizingCell.frame = CGRect(origin: sizingCell.frame.origin, size: CGSize(width: width, height: sizingCell.frame.height))
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        var cellSize = sizingCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        cellSize.width = collectionView.frame.width
        print(cellSize)
        return cellSize
    }
}


//// UICollectionView Vars and Constants
//let CellXIBName = YouViewCell.XIBName
//let CellReuseID = YouViewCell.ReuseID
//var sizingCell = YouViewCell()
//
//
//fileprivate func initCollectionView() {
//    // Connect to view controller
//    collectionView.dataSource = self
//    collectionView.delegate = self
//
//    // Register XIB
//    collectionView.register(UINib(nibName: CellXIBName, bundle: nil), forCellWithReuseIdentifier: CellReuseID)
//
//    // Create sizing cell for dynamically sizing cells
//    sizingCell = Bundle.main.loadNibNamed(CellXIBName, owner: self, options: nil)?.first as! YourViewCell
//
//    // Set scroll direction
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .vertical
//    collectionView.collectionViewLayout = layout
//
//    // Set properties
//    collectionView.alwaysBounceVertical = true
//    collectionView.alwaysBounceHorizontal = false
//
//    // Set top/bottom padding
//    collectionView.contentInset = UIEdgeInsets(top: collectionViewTopPadding, left: collectionViewSidePadding, bottom: collectionViewBottomPadding, right: collectionViewSidePadding)
//
//    // Hide scrollers
//    collectionView.showsVerticalScrollIndicator = false
//    collectionView.showsHorizontalScrollIndicator = false
//}
//
//
//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    // Get cell data and render post
//    let data = YourData[indexPath.row]
//    sizingCell.renderCell(data: data)
//
//    // Get cell size
//    sizingCell.setNeedsLayout()
//    sizingCell.layoutIfNeeded()
//    let cellSize = sizingCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//
//    // Return cell size
//    return cellSize
//}
