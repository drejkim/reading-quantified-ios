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
    
}
