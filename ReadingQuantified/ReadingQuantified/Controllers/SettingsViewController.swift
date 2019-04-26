//
//  SettingsViewController.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 3/30/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var viewModel: SettingsViewModel!
    
    // MARK: - IB Outlets & Actions
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        viewModel.processLogout()
    }
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

