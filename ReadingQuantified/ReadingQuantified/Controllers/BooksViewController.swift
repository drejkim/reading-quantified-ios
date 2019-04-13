//
//  BooksViewController.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 3/30/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BooksViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var viewModel: BooksViewModel!
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var numberOfBooksLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadBooks()
        
        bindSearchBar()
        bindSegmentedControl()
        bindNumberOfBooksLabel()
        bindTableView()
    }
    
    // MARK: - Private Functions
    
    private func bindSearchBar() {
        searchBar.rx.textDidBeginEditing
            .subscribe(onNext: { [weak self] event in
                guard let strongSelf = self else { return }
                
                strongSelf.searchBar.setShowsCancelButton(true, animated: true)
            })
            .disposed(by: bag)
        
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] event in
                guard let strongSelf = self else { return }
                
                strongSelf.searchBar.setShowsCancelButton(false, animated: true)
                strongSelf.searchBar.text = ""
                strongSelf.searchBar.endEditing(true)
            })
            .disposed(by: bag)
        
        searchBar.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] query in
                guard let strongSelf = self else { return }
                
                strongSelf.viewModel.filterBooks(by: query)
                
                // Update sorting based on the active segmented control
                strongSelf.viewModel.sortBooks(by: strongSelf.segmentedControl.selectedSegmentIndex)
            })
            .disposed(by: bag)
    }
    
    private func bindSegmentedControl() {
        segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                guard let strongSelf = self else { return }
                
                strongSelf.viewModel.sortBooks(by: index)
            })
            .disposed(by: bag)
    }
    
    private func bindNumberOfBooksLabel() {
        viewModel.books.asObservable()
            .subscribe(onNext: { [weak self] items in
                guard let strongSelf = self else { return }
                
                strongSelf.numberOfBooksLabel.text = items.count == 1 ? "\(items.count) Book" : "\(items.count) Books"
            })
            .disposed(by: bag)
    }
    
    private func bindTableView() {
        viewModel.books.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "BookCell", cellType: BookCell.self)) { row, book, cell in
                cell.configureCell(book: book)
            }
            .disposed(by: bag)
    }
}

