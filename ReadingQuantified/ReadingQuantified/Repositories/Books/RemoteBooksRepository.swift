//
//  RemoteBooksRepository.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/19/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Moya
import RxSwift

class RemoteBooksRepository: BooksRepository {
    
    private let keychainTokenRepository: KeychainTokenRepository
    private let provider: MoyaProvider<BooksService>
    
    init(keychainTokenRepository: KeychainTokenRepository) {
        self.keychainTokenRepository = keychainTokenRepository
        
        // Force unwrap token...
        let token = self.keychainTokenRepository.get()!
        
        self.provider = MoyaProvider<BooksService>(plugins: [
            AuthPlugin(accessToken: token.access),
            NetworkLoggerPlugin(verbose: true)])
    }
    
    func getAll() -> Observable<[Book]> {
        return provider.rx.request(.getBooks)
            .filterSuccessfulStatusCodes()
            .map([Book].self)
            .asObservable()
    }
    
}
