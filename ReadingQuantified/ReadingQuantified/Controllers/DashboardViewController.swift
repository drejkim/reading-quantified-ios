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
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        viewModel.refreshBooks()
        updateCollectionViewUI()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the collection view until the view has appeared
        collectionView.isHidden = true
        
        // Clear button text until books have been fetched
        yearSelectionButton.setTitle("", for: .normal)
        
        // Disable refresh button until books have been fetched
        refreshButton.isEnabled = false
        
        viewModel.refreshBooks()
        
        bindCollectionView()
        updateCollectionViewUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCollectionViewUI()
    }
    
    // MARK: - Private Functions
    
    private func updateCollectionViewUI() {
        viewModel.loadYearSelected()
        
        Observable.combineLatest(viewModel.booksAreRefreshedRelay, viewModel.yearSelectedRelay)
            .subscribe(onNext: { [weak self] areBooksRefreshed, year in
                guard let strongSelf = self else { return }
                
                if areBooksRefreshed {
                    strongSelf.yearSelectionButton.setTitle(year, for: .normal)
                    strongSelf.refreshButton.isEnabled = true
                    strongSelf.viewModel.loadMetrics(by: year)
                }
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

