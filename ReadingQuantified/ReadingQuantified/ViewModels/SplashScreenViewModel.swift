//
//  SplashScreenViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/20/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class SplashScreenViewModel {
    
    // MARK: - Dependencies
    
    private let session: Session
    
    init(session: Session) {
        self.session = session
        
        // TEMPORARY: For testing only
        self.session.token = Token(refresh: "abcd", access: "efgh")
    }
    
    // MARK: - Properties
    
    let isLoggedIn = BehaviorRelay<Bool>(value: true)
    
}
