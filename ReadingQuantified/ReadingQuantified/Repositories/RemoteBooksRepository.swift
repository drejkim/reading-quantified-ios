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
    
    private let token: Token
    private let provider: MoyaProvider<BooksService>
    
    init(token: Token) {
        self.token = token
        self.provider = MoyaProvider<BooksService>(plugins: [AuthPlugin(accessToken: token.access)])
    }
    
    func getAll() -> Observable<[Book]> {
        return provider.rx.request(.getBooks)
            .filterSuccessfulStatusCodes()
            .map([Book].self)
            .asObservable()
    }
    
}
