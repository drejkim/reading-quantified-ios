//
//  LoginViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 3/30/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa

class LoginViewModel {
    
    // MARK: - Dependencies
    
    private let keychainTokenRepository: KeychainTokenRepository
    private let remoteTokenRepository: RemoteTokenRepository
    
    init(keychainTokenRepository: KeychainTokenRepository, remoteTokenRepository: RemoteTokenRepository) {
        self.keychainTokenRepository = keychainTokenRepository
        self.remoteTokenRepository = remoteTokenRepository
    }
    
    // MARK: - Properties
    
    enum LoginStatus {
        case notProcessed, processing, valid, invalid
    }
    
    let status = BehaviorRelay<LoginStatus>(value: .notProcessed)
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - Functions
    
    func validateCredentials(inputUsername: String?, inputPassword: String?) {
        guard
            let username = inputUsername,
            let password = inputPassword else { return }
        
        self.status.accept(.processing)
        
        self.remoteTokenRepository.obtainTokenPair(username: username, password: password)
            .subscribe(
                onNext: { [weak self] token in
                    guard let strongSelf = self else { return }
                    
                    let tokenSaveSuccessful = strongSelf.keychainTokenRepository.save(token)
                    
                    if tokenSaveSuccessful {
                        strongSelf.status.accept(.valid)
                    }
                    else {
                        strongSelf.status.accept(.invalid)
                    }
                },
                onError: { [weak self] _ in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.status.accept(.invalid)
                }
            )
            .disposed(by: bag)
    }
    
    func getStatusMessage(status: LoginStatus) -> String {
        switch status {
        case .notProcessed:
            return "Welcome."
        case .processing:
            return "Processing..."
        case .valid:
            return "Success!"
        case .invalid:
            return "Invalid credentials. Try again."
        }
    }
    
    func hideLoginButton(status: LoginStatus) -> Bool {
        switch status {
        case .processing:
            return true
        case .valid:
            return true
        default:
            return false
        }
    }
    
}
