//
//  LocalBooksRepository.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/19/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Realm
import RealmSwift
import RxSwift
import RxRealm

class LocalBooksRepository: BooksRepository {
    
    func getAll() -> Observable<[Book]> {
        let realm = try! Realm()
        let books = realm.objects(Book.self)
        
        return Observable.array(from: books, synchronousStart: false)
    }
    
    func save(_ books: [Book]) {
        let realm = try! Realm()
        
        try! realm.write {
            // Overwrite an object if it already exists
            realm.add(books, update: true)
        }
    }
    
}
