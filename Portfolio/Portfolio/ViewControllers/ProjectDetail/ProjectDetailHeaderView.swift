//
//  ProjectDetailHeaderView.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/28/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class ProjectDetailHeaderView: UICollectionReusableView {

    // MARK: - Public Properties
    
    var project: Project? { didSet { updateViews() } }
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var summaryLabel: UILabel!
    @IBOutlet private var roleLabel: UILabel!
    @IBOutlet private var technologiesLabel: UILabel!
    
    func updateViews() {
        guard let project = project else { return }
        nameLabel.text = project.name
        summaryLabel.text = project.summary
        roleLabel.text = project.role
        technologiesLabel.attributedText = .bulletPointList(strings: project.technologies.map { String($0) })
    }
}
