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
    
    private let session: Session
    private let provider: MoyaProvider<BooksService>
    
    init(session: Session) {
        self.session = session
        
        // QUESTION: Is force unwrapping token okay?
        self.provider = MoyaProvider<BooksService>(plugins: [AuthPlugin(accessToken: session.token!.access)])
    }
    
    func getAll() -> Observable<[Book]> {
        return provider.rx.request(.getBooks)
            .filterSuccessfulStatusCodes()
            .map([Book].self)
            .asObservable()
    }
    
}
