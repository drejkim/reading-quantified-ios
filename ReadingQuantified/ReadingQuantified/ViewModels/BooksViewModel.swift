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
    
    private let session: SessionService
    
    init(session: SessionService) {
        self.session = session
    }
    
    // MARK: - Properties
    
    var books = BehaviorRelay<[Book]>(value: [])
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    private enum Segment: Int {
        case Title, DateStarted, DateFinished
    }
    
    // MARK: - Functions
    
    func loadBooks() {
        guard let token = self.session.token else { return }
        
        let provider = MoyaProvider<BooksService>(plugins: [AuthPlugin(accessToken: token.access)])
        provider.request(.getBooks) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try response.map([Book].self)
                    self.books.accept(results)
                } catch let error {
                    print(error)
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func sortBooks(by segmentedControlIndex: Int) {
        guard let selectedSegment = Segment(rawValue: segmentedControlIndex) else { return }
        
        switch selectedSegment {
        case .Title:
            // Sort alphabetically
            books.accept(books.value.sorted(by: { (item1, item2) -> Bool in
                item1.title < item2.title
            }))
        case .DateStarted:
            // Sort date in descending order
            books.accept(books.value.sorted(by: { (item1, item2) -> Bool in
                item1.date_started > item2.date_started
            }))
        case .DateFinished:
            // Sort date in descending order
            books.accept(books.value.sorted(by: { (item1, item2) -> Bool in
                item1.date_finished > item2.date_finished
            }))
        }
    }
    
}
