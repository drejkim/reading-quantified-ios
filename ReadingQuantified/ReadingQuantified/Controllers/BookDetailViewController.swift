//
//  BookDetailViewController.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/13/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var viewModel = BookDetailViewModel()
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateStartedLabel: UILabel!
    @IBOutlet weak var dateFinishedLabel: UILabel!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        guard let book = viewModel.book else { return }
        
        // TODO: formatDateString() should be moved out of BookCellViewModel... it'll be used a lot
        let bookCellViewModel = BookCellViewModel()
        
        titleLabel.text = book.title
        titleLabel.numberOfLines = 0
        
        dateStartedLabel.text = bookCellViewModel.formatDateString(from: book.date_started)
        dateFinishedLabel.text = bookCellViewModel.formatDateString(from: book.date_finished)
    }
    
}
