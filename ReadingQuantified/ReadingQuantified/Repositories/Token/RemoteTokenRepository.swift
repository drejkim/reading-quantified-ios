//
//  RemoteTokenRepository.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/25/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Moya
import RxSwift

class RemoteTokenRepository {
    
    private let provider: MoyaProvider<TokenService>
    
    init() {
        self.provider = MoyaProvider<TokenService>()
    }
    
    func obtainTokenPair(username: String, password: String) -> Observable<Token> {
        return provider.rx.request(.obtainTokenPair(username: username, password: password))
            .map(Token.self)
            .asObservable()
    }
    
    func verifyToken(token: String) -> Observable<Bool> {
        return provider.rx.request(.verifyToken(token: token))
            .map({ response -> Bool in
                return response.statusCode == 200 ? true : false
            })
            .asObservable()
    }
}
