//
//  SortItemCell.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/18/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit

class SortItemCell: UITableViewCell {
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var sortDirectionView: UIImageView!
    @IBOutlet weak var sortItemLabel: UILabel!
    
    // MARK: - Functions
    
    func configureCell(sortItem: SortItem) {
        sortItemLabel.text = sortItem.label.rawValue
        
        updateColor(for: sortItem)
        updateSortDirectionView(for: sortItem)
        
    }
    
    // MARK: - Private Functions
    
    private func updateColor(for sortItem: SortItem) {
        if sortItem.isActive {
            self.backgroundColor = UIColor(named: "bg_primary")
            sortItemLabel.textColor = UIColor(named: "text_white")
            sortDirectionView.tintColor = UIColor(named: "text_white")
        }
        else {
            self.backgroundColor = nil
            sortItemLabel.textColor = UIColor(named: "text_muted")
            sortDirectionView.tintColor = UIColor(named: "text_muted")
        }
    }
    
    private func updateSortDirectionView(for sortItem: SortItem) {
        if sortItem.isActive {
            sortDirectionView.alpha = 1.0
            
            if sortItem.direction == .ascending {
                sortDirectionView.image = UIImage(named: "baseline_arrow_upward_black_24pt")
            }
            else {
                sortDirectionView.image = UIImage(named: "baseline_arrow_downward_black_24pt")
            }
        }
        else {
            sortDirectionView.alpha = 0.0
        }
    }
    
}
