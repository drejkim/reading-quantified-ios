//
//  TokenService.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/2/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Moya

enum TokenService {
    case obtainTokenPair(username: String, password: String)
    case refreshToken(token: String)
    case verifyToken(token: String)
}

extension TokenService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .obtainTokenPair(_, _):
            return "/api/token/"
        case .refreshToken(_):
            return "/api/token/refresh/"
        case .verifyToken(_):
            return "/api/token/verify/"
        }
    }
    
    var method: Method {
        switch self {
        case .obtainTokenPair:
            return .post
        case .refreshToken:
            return .post
        case .verifyToken:
            return .post
        }
    }
    
    var sampleData: Data {
        // Return nothing for now
        return Data()
    }
    
    var task: Task {
        switch self {
        case .obtainTokenPair(let username, let password):
            return .requestParameters(parameters: [
                "username": username,
                "password": password
            ], encoding: JSONEncoding.default)
        case .refreshToken(let token):
            return .requestParameters(parameters: [
                "refresh": token
            ], encoding: JSONEncoding.default)
        case .verifyToken(let token):
            return .requestParameters(parameters: [
                "token": token
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
