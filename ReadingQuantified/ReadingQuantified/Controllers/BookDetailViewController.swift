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
    
    var viewModel = BookViewModel()
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateStartedLabel: UILabel!
    @IBOutlet weak var dateFinishedLabel: UILabel!
    @IBOutlet weak var daysToFinishLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        guard let book = viewModel.book else { return }
        
        titleLabel.text = book.title
        titleLabel.numberOfLines = 0
        
        dateStartedLabel.text = viewModel.formatDateString(from: book.date_started, to: DateFormatter.Style.long)
        dateFinishedLabel.text = viewModel.formatDateString(from: book.date_finished, to: DateFormatter.Style.long)
        
        daysToFinishLabel.text = String(book.days_to_finish)
    }
    
}
