//
//  BooksViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/6/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa

class BooksViewModel {
    
    // MARK: - Dependencies
    
    private let booksRepositoryManager: BooksRepositoryManager
    
    init(booksRepositoryManager: BooksRepositoryManager) {
        self.booksRepositoryManager = booksRepositoryManager
    }
    
    // MARK: - Properties
    
    var booksRelay = BehaviorRelay<[Book]>(value: [])
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    private var books: [Book] = []
    
    private enum Segment: Int {
        case Title, DateStarted, DateFinished
    }
    
    // MARK: - Functions
    
    func loadBooks() {
        booksRepositoryManager.getAll(from: .local)
            .subscribe(onNext: { [weak self] books in
                guard let strongSelf = self else { return }
                
                strongSelf.books = books
                strongSelf.booksRelay.accept(books)
            })
            .disposed(by: bag)
    }
    
    func refreshBooks() {
        booksRepositoryManager.getAll(from: .remote)
            .subscribe(onNext: { [weak self] books in
                guard let strongSelf = self else { return }
                
                strongSelf.books = books
                strongSelf.booksRelay.accept(books)
            })
            .disposed(by: bag)
    }
    
    func filterBooks(by query: String) {
        // Show the entire list of available books if there is no search term
        if(query.isEmpty) {
            booksRelay.accept(self.books)
        }
        // Filtering should be done on the original list of book results
        else {
            booksRelay.accept(self.books.filter({ (item) -> Bool in
                return item.title.lowercased().contains(query.lowercased()) ||
                    
                       // TODO: Enhance date search
                       item.date_started.contains(query) ||
                       item.date_finished.contains(query)
            }))
        }
    }
    
    func sortBooks(by segmentedControlIndex: Int) {
        guard let selectedSegment = Segment(rawValue: segmentedControlIndex) else { return }
        
        switch selectedSegment {
        case .Title:
            // Sort alphabetically
            booksRelay.accept(booksRelay.value.sorted(by: { (item1, item2) -> Bool in
                item1.title < item2.title
            }))
        case .DateStarted:
            // Sort date in descending order
            booksRelay.accept(booksRelay.value.sorted(by: { (item1, item2) -> Bool in
                item1.date_started > item2.date_started
            }))
        case .DateFinished:
            // Sort date in descending order
            booksRelay.accept(booksRelay.value.sorted(by: { (item1, item2) -> Bool in
                item1.date_finished > item2.date_finished
            }))
        }
    }
    
}
