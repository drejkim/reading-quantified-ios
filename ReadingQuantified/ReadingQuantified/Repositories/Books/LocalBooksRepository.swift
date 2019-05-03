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
    
    func filter(by year: String) -> Observable<[Book]> {
        let realm = try! Realm()
        let books = realm.objects(Book.self).filter("date_finished BEGINSWITH '\(year)'")
        
        return Observable.array(from: books)
    }
    
    func filter(by year: String, sortedBy key: String) -> Observable<[Book]> {
        let realm = try! Realm()
        let books = realm.objects(Book.self).filter("date_finished BEGINSWITH '\(year)'").sorted(byKeyPath: key)
        
        return Observable.array(from: books)
    }
    
    // Return the value rather than an Observable for the following...
    
    func getShortestRead(filteredBy year: String) -> Book? {
        let realm = try! Realm()
        let books = realm.objects(Book.self).filter("date_finished BEGINSWITH '\(year)'")
        
        return books.min(by: { $0.days_to_finish < $1.days_to_finish })
    }
    
    func getLongestRead(filteredBy year: String) -> Book? {
        let realm = try! Realm()
        let books = realm.objects(Book.self).filter("date_finished BEGINSWITH '\(year)'")
        
        return books.max(by: { $0.days_to_finish < $1.days_to_finish })
    }
    
    func getAvgDaysToFinish(filteredBy year: String) -> Float? {
        let realm = try! Realm()
        let books = realm.objects(Book.self).filter("date_finished BEGINSWITH '\(year)'")
        
        return books.average(ofProperty: "days_to_finish")
    }
    
}
