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
    
    func configureCell(year: Year) {
        yearLabel.text = year.value
        
        updateColor(for: year)
    }
    
    // MARK: - Private Functions
    
    private func updateColor(for year: Year) {
        if year.isActive {
            self.backgroundColor = UIColor(named: "bg_primary")
            yearLabel.textColor = UIColor(named: "text_white")
        }
        else {
            self.backgroundColor = nil
            yearLabel.textColor = UIColor(named: "text_muted")
        }
    }
}
