//
//  MetricCell.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/1/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit

class MetricCell: UICollectionViewCell {
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - Functions
    
    func configureCell(metric: Metric) {
        titleLabel.text = metric.title
        valueLabel.text = metric.value
        
        if metric.caption == nil {
            captionLabel.isHidden = true
        }
        else {
            captionLabel.isHidden = false
            captionLabel.text = metric.caption
        }
    }
}
