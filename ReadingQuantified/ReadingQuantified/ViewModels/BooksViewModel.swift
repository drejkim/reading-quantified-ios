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
    private let coordinator: SortByCoordinator
    
    init(booksRepositoryManager: BooksRepositoryManager, coordinator: SortByCoordinator) {
        self.booksRepositoryManager = booksRepositoryManager
        self.coordinator = coordinator
    }
    
    // MARK: - Properties
    
    var booksRelay = BehaviorRelay<[Book]>(value: [])
    var activeSortItemRelay = PublishSubject<SortItem>()
    
    enum ScopeButton: Int {
        case Title, DateStarted, DateFinished
        
        var title: String {
            switch self {
            case .Title:
                return "Title"
                
            case .DateStarted:
                return "Date Started"
                
            case .DateFinished:
                return "Date Finished"
            }
        }
    }
    
    let scopeButtonTitles = [
        ScopeButton.Title.title,
        ScopeButton.DateStarted.title,
        ScopeButton.DateFinished.title
    ]
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    private var books: [Book] = []
    
    // MARK: - Functions
    
    func loadBooks() {
        booksRepositoryManager.getAll(from: .local)
            .subscribe(onNext: { [weak self] books in
                guard let strongSelf = self else { return }
                
                strongSelf.books = books
                strongSelf.booksRelay.accept(books)
                
                // Make sure the books are sorted
                strongSelf.activeSortItemRelay.onNext(SortItem(label: .DateFinished, direction: .descending, isActive: true))
            })
            .disposed(by: bag)
    }
    
    func refreshBooks() {
        booksRepositoryManager.getAll(from: .remote)
            .subscribe(onNext: { [weak self] books in
                guard let strongSelf = self else { return }
                
                strongSelf.books = books
                strongSelf.booksRelay.accept(books)
                strongSelf.booksRepositoryManager.save(books)
            })
            .disposed(by: bag)
    }
    
    func getSearchPlaceholderText(scopeButton: ScopeButton) -> String {
        switch scopeButton {
        case .Title:
            return "Ex: Harry Potter"
        case .DateStarted, .DateFinished:
            return "Ex: 2019, April 2019, Apr 2019"
        }
    }
    
    func filterBooks(by query: String, selectedScopeButtonIndex: Int) {
        // Show the entire list of available books if there is no search term
        if(query.isEmpty) {
            booksRelay.accept(self.books)
        }
        // Filtering should be done on the original list of book results
        else if selectedScopeButtonIndex == ScopeButton.Title.rawValue {
            booksRelay.accept(self.books.filter({ (item) -> Bool in
                return item.title.lowercased().contains(query.lowercased())
            }))
        }
        else if selectedScopeButtonIndex == ScopeButton.DateStarted.rawValue {
            booksRelay.accept(self.books.filter({ (item) -> Bool in
                return filterBooks(for: item.date_started, with: query)
            }))
        }
        else if selectedScopeButtonIndex == ScopeButton.DateFinished.rawValue {
            booksRelay.accept(self.books.filter({ (item) -> Bool in
                return filterBooks(for: item.date_finished, with: query)
            }))
        }
    }
    
    func loadActiveSortItem() {
        coordinator.sortItemsRelay.asObservable()
            .subscribe(onNext: { [weak self] items in
                guard
                    let strongSelf = self,
                    let activeItem = items.filter({ $0.isActive }).first else { return }
                
                strongSelf.activeSortItemRelay.onNext(activeItem)
            })
            .disposed(by: bag)
    }
    
    func sortBooks(using item: SortItem) {
        switch item.label {
        case .Title:
            booksRelay.accept(booksRelay.value.sorted(by: { (item1, item2) -> Bool in
                item.direction == .ascending ? item1.title < item2.title : item1.title > item2.title
            }))
        case .DateStarted:
            booksRelay.accept(booksRelay.value.sorted(by: { (item1, item2) -> Bool in
                item.direction == .ascending ? item1.date_started < item2.date_started : item1.date_started > item2.date_started
            }))
        case .DateFinished:
            booksRelay.accept(booksRelay.value.sorted(by: { (item1, item2) -> Bool in
                item.direction == .ascending ? item1.date_finished < item2.date_finished : item1.date_finished > item2.date_finished
            }))
        }
    }
    
    // MARK: - Private Functions
    
    private func filterBooks(for dateString: String, with query: String) -> Bool {
        let bookViewModel = BookViewModel()
        let formattedDate = bookViewModel.formatDateString(from: dateString, to: "MMMM yyyy").lowercased()
        
        let queryElements = query.components(separatedBy: " ")
        var result = true
        for element in queryElements {
            result = result && formattedDate.contains(element.lowercased())
        }
        
        return result
    }
    
}
