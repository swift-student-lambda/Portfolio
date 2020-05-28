//
//  CodeViewController.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/28/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit
import WebKit

class CodeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var webView: WKWebView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
}
