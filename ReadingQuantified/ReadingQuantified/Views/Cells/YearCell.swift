//
//  YearCell.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/2/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit

class YearCell: UITableViewCell {
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var yearLabel: UILabel!
    
    // MARK: - Functions
    
    func configureCell(year: String) {
        yearLabel.text = year
    }
}
