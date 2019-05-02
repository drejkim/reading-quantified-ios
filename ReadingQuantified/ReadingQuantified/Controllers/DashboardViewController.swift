//
//  DashboardViewController.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 3/30/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DashboardViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var viewModel: DashboardViewModel!
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindCollectionView()
    }
    
    // MARK: - Private Functions
    
    private func bindCollectionView() {
        viewModel.loadMetrics()
        
        viewModel.metricsRelay.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: "MetricCell", cellType: MetricCell.self)) { row, metric, cell in
                print(metric)
                cell.configureCell(metric: metric)
            }
            .disposed(by: bag)
    }
    
}

