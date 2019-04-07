//
//  BooksService.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/6/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Moya

enum BooksService {
    case getBooks
}

extension BooksService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getBooks:
            return "/api/books/"
        }
    }
    
    var method: Method {
        switch self {
        case .getBooks:
            return .get
        }
    }
    
    var sampleData: Data {
        // Return nothing for now
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getBooks:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
