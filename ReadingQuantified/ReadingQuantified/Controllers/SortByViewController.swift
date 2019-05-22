//
//  SortByViewController.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/17/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SortByViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var viewModel: SortByViewModel!
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - IB Actions & Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadSortItems()
        bindTableView()
    }
    
    // MARK: - Private Functions
    
    private func bindTableView() {
        viewModel.sortItemsRelay.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "SortItemCell", cellType: SortItemCell.self)) { row, sortItem, cell in
                cell.configureCell(sortItem: sortItem)
            }
            .disposed(by: bag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(SortItem.self))
            .bind { [weak self] indexPath, sortItem in
                guard let strongSelf = self else { return }
                
                strongSelf.viewModel.updateActiveSortItem(sortItem)
                strongSelf.tableView.deselectRow(at: indexPath, animated: true)
                strongSelf.dismiss(animated: true, completion: nil)
            }
            .disposed(by: bag)
    }
    
}
