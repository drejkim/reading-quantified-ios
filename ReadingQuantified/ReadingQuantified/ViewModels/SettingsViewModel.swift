//
//  SettingsViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/26/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

class SettingsViewModel {
    
    // MARK: - Dependencies
    
    private let keychainTokenRepository: KeychainTokenRepository
    
    init(keychainTokenRepository: KeychainTokenRepository) {
        self.keychainTokenRepository = keychainTokenRepository
    }
    
    // MARK: - Functions
    
    func processLogout() {
        keychainTokenRepository.remove()
    }
    
}
