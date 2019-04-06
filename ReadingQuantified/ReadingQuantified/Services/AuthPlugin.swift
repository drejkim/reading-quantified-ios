//
//  AuthPlugin.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/6/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Moya

struct AuthPlugin: PluginType {
    let accessToken: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        return request
    }
}
