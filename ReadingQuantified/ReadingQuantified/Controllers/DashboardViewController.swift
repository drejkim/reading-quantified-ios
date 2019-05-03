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
    
    private let collectionViewWidthPadding: CGFloat = 24.0
    private let collectionViewCellHeight: CGFloat = 72.0
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var yearSelectionButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the collection view until the view has appeared
        collectionView.isHidden = true
        
        updateOnYearSelected()
        
        // TODO: Fix bug on first time installs
        bindCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCollectionViewUI()
    }
    
    // MARK: - Private Functions
    
    private func updateOnYearSelected() {
        viewModel.loadYearSelected()
        viewModel.yearSelectedRelay.asObservable()
            .subscribe(onNext: { [weak self] year in
                guard let strongSelf = self else { return }
                
                strongSelf.yearSelectionButton.setTitle(year, for: .normal)
                strongSelf.viewModel.loadMetrics(by: year)
            })
            .disposed(by: bag)
    }
    
    private func setupCollectionViewUI() {
        collectionView.isHidden = false
        
        let frame = self.view.safeAreaLayoutGuide.layoutFrame
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize.init(width: frame.width - collectionViewWidthPadding, height: collectionViewCellHeight)
    }
    
    private func bindCollectionView() {
        viewModel.metricsRelay.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: "MetricCell", cellType: MetricCell.self)) { row, metric, cell in
                cell.configureCell(metric: metric)
            }
            .disposed(by: bag)
    }
    
}

