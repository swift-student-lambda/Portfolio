//
//  ViewController.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/26/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let networkClient = NetworkClient()
    
    override func viewDidLoad() {
        
        networkClient.fetchAllProjects { (result) in
            switch result {
            case .failure(let error):
                print("⚠️ There was an error fetching all projects: \(error)")
            case .success(let projects):
                print("😁 Successfully fetched all projects: \(projects)")
            }
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

