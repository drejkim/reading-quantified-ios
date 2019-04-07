//
//  BooksViewController.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 3/30/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var viewModel: BooksViewModel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadBooks()
    }
    
}

