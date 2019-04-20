//
//  LocalBooksRepository.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/19/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift

class LocalBooksRepository: BooksRepository {
    
    // TODO: Hard-code books variable for now
    var books: [Book] = [
        Book(url: "http://localhost:8000/api/books/1/",
             genres: ["564d07a87721d8698ff010d8"],
             created_at: "2019-04-06T16:46:00.354844Z",
             updated_at: "2019-04-06T16:46:00.354863Z",
             title: "The Age of Innocence",
             trello_id: "564d07a87721d8698ff010f3",
             date_started: "2016-06-18T16:18:30.373000Z",
             date_finished: "2016-06-29T02:39:03.355000Z")
    ]
    
    
    func getAll() -> Observable<[Book]> {
        
        // TODO: Return Realm observable... return hard-coded books variable for now
        return Observable<[Book]>.just(books)
    }
    
    func save() -> Observable<Bool> {
        
        // TODO: Implement function
        return Observable<Bool>.just(false)
    }
    
}
