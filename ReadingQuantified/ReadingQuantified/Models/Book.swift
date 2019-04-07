//
//  Book.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/6/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

struct Book: Decodable {
    let url: String
    let genres: [String]
    let created_at: String
    let updated_at: String
    let title: String
    let trello_id: String
    let date_started: String
    let date_finished: String
}
