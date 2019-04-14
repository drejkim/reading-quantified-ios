//
//  BookCell.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/7/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    // MARK: - Dependencies
    
    var viewModel = BookViewModel()
    
    // MARK: - IB Outlet & Actions
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: - Functions
    
    func configureCell(book: Book) {
        titleLabel.text = book.title
        subtitleLabel.text = "\(viewModel.formatDateString(from: book.date_started, to: DateFormatter.Style.medium)) to \(viewModel.formatDateString(from: book.date_finished, to: DateFormatter.Style.medium))"
    }
    
}
