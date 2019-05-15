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
    
    // MARK: - Properties
    
    var searchBar = UISearchBar()
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    private var selectedBook: Book?
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var numberOfBooksLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(BooksViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BooksViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Load books from local repository
        viewModel.loadBooks()
        
        setupSearchBar()
        setupRefreshControl()
        
        bindSearchBar()
        bindNumberOfBooksLabel()
        bindTableView()
    }
    
    // MARK: - Keyboard Functions
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let tabBarHeight = self.tabBarController?.tabBar.frame.height else { return }
        
        let keyboardHeight = keyboardValue.cgRectValue.height
        
        updateTableViewInsets(for: keyboardHeight - tabBarHeight)
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        updateTableViewInsets(for: 0.0)
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
        
        searchBar.rx.selectedScopeButtonIndex
            .subscribe(onNext: { [weak self] index in
                guard
                    let strongSelf = self,
                    let selectedScopeButton = BooksViewModel.ScopeButton(rawValue: index) else { return }
                
                strongSelf.searchBar.placeholder = strongSelf.viewModel.getSearchPlaceholderText(scopeButton: selectedScopeButton)
            })
            .disposed(by: bag)
        
        // Use scope bar in conjunction with search
        Observable.combineLatest(searchBar.rx.selectedScopeButtonIndex, searchBar.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] selectedScopeButtonIndex, query in
                guard let strongSelf = self else { return }
                
                strongSelf.viewModel.filterBooks(by: query, selectedScopeButtonIndex: selectedScopeButtonIndex)
            })
            .disposed(by: bag)
    }
    
    private func bindNumberOfBooksLabel() {
        viewModel.booksRelay.asObservable()
            .subscribe(onNext: { [weak self] items in
                guard let strongSelf = self else { return }
                
                strongSelf.numberOfBooksLabel.text = items.count == 1 ? "\(items.count) Book" : "\(items.count) Books"
            })
            .disposed(by: bag)
    }
    
    private func bindTableView() {
        viewModel.booksRelay.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "BookCell", cellType: BookCell.self)) { row, book, cell in
                cell.configureCell(book: book)
            }
            .disposed(by: bag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Book.self))
            .bind { [weak self] indexPath, book in
                guard let strongSelf = self else { return }
                
                strongSelf.selectedBook = book
                strongSelf.tableView.deselectRow(at: indexPath, animated: true)
                strongSelf.performSegue(withIdentifier: Constants.SegueIdentifiers.bookDetailViewController, sender: strongSelf)
            }
            .disposed(by: bag)
    }
    
    private func updateTableViewInsets(for bottomValue: CGFloat) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomValue, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: bottomValue, right: 0)
    }
    
    private func setupSearchBar() {
        // Move search bar into navigation bar
        self.navigationItem.titleView = searchBar
        
        searchBar.barTintColor = UIColor(named: "bg_light")
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = viewModel.scopeButtonTitles
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        
        refreshControl.backgroundColor = UIColor(named: "bg_white")
        refreshControl.tintColor = UIColor(named: "text_muted")
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching books...",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "text_muted")!])
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.refreshBooks()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.SegueIdentifiers.bookDetailViewController) {
            let vc = segue.destination as! BookDetailViewController
            vc.viewModel.book = selectedBook
        }
    }

}
