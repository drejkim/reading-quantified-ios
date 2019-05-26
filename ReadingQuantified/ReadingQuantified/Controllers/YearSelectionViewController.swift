//
//  YearSelectionViewController.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/2/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class YearSelectionViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var viewModel: YearSelectionViewModel!
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadYears()
        bindTableView()
    }
    
    private func bindTableView() {
        viewModel.yearsRelay.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "YearCell", cellType: YearCell.self)) { row, year, cell in
                cell.configureCell(year: year)
            }
            .disposed(by: bag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Year.self))
            .bind { [weak self] indexPath, year in
                guard let strongSelf = self else { return }
                
                strongSelf.viewModel.updateYearSelected(year)
                strongSelf.tableView.deselectRow(at: indexPath, animated: true)
                strongSelf.dismiss(animated: true, completion: nil)
            }
            .disposed(by: bag)
    }
    
}
