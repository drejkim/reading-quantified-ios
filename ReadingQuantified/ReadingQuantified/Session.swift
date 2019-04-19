//
//  Session.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/6/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

class Session {
    
    var token: Token? {
        // TEST: Print out token values
        didSet {
            print(token!.access)
            print(token!.refresh)
        }
    }
    
}
