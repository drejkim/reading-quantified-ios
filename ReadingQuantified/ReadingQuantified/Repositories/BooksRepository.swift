//
//  BooksRepository.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/19/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift

protocol BooksRepository {
    
    func getAll() -> Observable<[Book]>
    
}
