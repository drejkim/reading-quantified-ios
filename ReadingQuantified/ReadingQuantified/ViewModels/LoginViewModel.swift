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
    
    enum LoginStatus {
        case notProcessed, processing, valid, invalid
    }
    
    let status = BehaviorRelay<LoginStatus>(value: .notProcessed)
    
    private let session: SessionService
    
    init(session: SessionService) {
        self.session = session
    }
    
    // MARK: - Functions
    
    func validateCredentials(inputUsername: String?, inputPassword: String?) {
        guard
            let username = inputUsername,
            let password = inputPassword else { return }
        
        self.status.accept(.processing)
        
        let provider = MoyaProvider<TokenService>()
        provider.request(.obtainTokenPair(username: username, password: password)) { result in
            switch result {
            case let .success(response):
                do {
                    self.session.token = try response.map(Token.self)
                    self.status.accept(.valid)
                } catch let error {
                    self.status.accept(.invalid)
                    print(error)
                }
                
            case let .failure(error):
                self.status.accept(.invalid)
                print(error)
            }
        }
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
