//
//  KeychainTokenRepository.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/24/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import SwiftKeychainWrapper

class KeychainTokenRepository {
    
    private struct Keys {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }
    
    func get() -> Token? {
        guard
            let accessToken = KeychainWrapper.standard.string(forKey: Keys.accessToken),
            let refreshToken = KeychainWrapper.standard.string(forKey: Keys.refreshToken) else { return nil }
        
        return Token(refresh: refreshToken, access: accessToken)
    }
    
    func save(_ token: Token) -> Bool {
        let accessTokenSaveSuccessful = KeychainWrapper.standard.set(token.access, forKey: Keys.accessToken)
        let refreshTokenSaveSuccessful = KeychainWrapper.standard.set(token.refresh, forKey: Keys.refreshToken)
        
        return accessTokenSaveSuccessful && refreshTokenSaveSuccessful
    }
    
    func remove() -> Bool {
        let accessTokenRemoveSuccessful = KeychainWrapper.standard.removeObject(forKey: Keys.accessToken)
        let refreshTokenRemoveSuccessful = KeychainWrapper.standard.removeObject(forKey: Keys.refreshToken)
        
        return accessTokenRemoveSuccessful && refreshTokenRemoveSuccessful
    }
    
}
