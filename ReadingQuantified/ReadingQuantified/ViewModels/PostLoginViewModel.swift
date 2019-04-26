//
//  PostLoginViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/26/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class PostLoginViewModel {
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - Functions
    
    func fetchBooks() {
        // Create repositories here to ensure there is a valid token to fetch books
        let keychainTokenRepository = KeychainTokenRepository()
        let localBooksRepository = LocalBooksRepository()
        let remoteBooksRepository = RemoteBooksRepository(keychainTokenRepository: keychainTokenRepository)
        let booksRepositoryManager = BooksRepositoryManager(local: localBooksRepository, remote: remoteBooksRepository)
        
        booksRepositoryManager.getAll(from: .remote)
            .subscribe(onNext: { books in
                
                booksRepositoryManager.save(books)
            })
            .disposed(by: bag)
    }
    
}
