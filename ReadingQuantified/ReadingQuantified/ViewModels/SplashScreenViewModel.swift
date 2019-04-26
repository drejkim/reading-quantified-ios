//
//  SplashScreenViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/20/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class SplashScreenViewModel {
    
    // MARK: - Dependencies
    
    private let keychainTokenRepository: KeychainTokenRepository
    private let remoteTokenRepository: RemoteTokenRepository
    
    init(keychainTokenRepository: KeychainTokenRepository, remoteTokenRepository: RemoteTokenRepository) {
        self.keychainTokenRepository = keychainTokenRepository
        self.remoteTokenRepository = remoteTokenRepository
    }
    
    // MARK: - Properties
    
    let isLoggedIn = PublishSubject<Bool>()
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - Functions
    
    func checkIfLoggedIn() {
        let tokenOptional = self.keychainTokenRepository.get()

        if let token = tokenOptional {
            // Verify just the access token for now
            self.remoteTokenRepository.verifyToken(token: token.access)
                .subscribe(onNext: { [weak self] result in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.isLoggedIn.onNext(result)
                })
                .disposed(by: bag)
        }
        else {
            self.isLoggedIn.onNext(false)
        }
    }
    
    func fetchBooks() {
        // Create repositories here to ensure there is a valid token to fetch books
        let localBooksRepository = LocalBooksRepository()
        let remoteBooksRepository = RemoteBooksRepository(keychainTokenRepository: self.keychainTokenRepository)
        let booksRepositoryManager = BooksRepositoryManager(local: localBooksRepository, remote: remoteBooksRepository)
        
        booksRepositoryManager.getAll(from: .remote)
            .subscribe(onNext: { books in
                
                booksRepositoryManager.save(books)
            })
            .disposed(by: bag)
    }
    
}
