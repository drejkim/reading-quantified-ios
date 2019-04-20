//
//  BooksRepositoryManager.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/19/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class BooksRepositoryManager {
    
    // MARK: - Dependencies
    
    private let local: LocalBooksRepository
    private let remote: RemoteBooksRepository
    
    init(local: LocalBooksRepository, remote: RemoteBooksRepository) {
        self.local = local
        self.remote = remote
    }
    
    // MARK: - Properties
    
    enum RepositoryType {
        case local, remote
    }
    
    // MARK: - Functions
    
    func getAll(from source: RepositoryType) -> Observable<[Book]> {
        switch source {
        case .local:
            return local.getAll()
        case .remote:
            return remote.getAll()
        }
    }
    
    func save(_ books: [Book]) {
        
        return local.save(books)
    }
    
}
