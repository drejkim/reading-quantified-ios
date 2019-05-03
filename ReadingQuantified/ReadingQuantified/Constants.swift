//
//  Constants.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/2/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

struct Constants {
    static let baseURL = "https://reading-quantified-server.herokuapp.com"
//    static let baseURL = "http://localhost:8000"
    
    // Segue Identifiers
    struct SegueIdentifiers {
        static let bookDetailViewController = "goToBookDetail"
        static let goToMainFromLogin = "goToMainFromLogin"
        static let goToMainFromSplashScreen = "goToMainFromSplashScreen"
        static let goToLoginFromSplashScreen = "goToLoginFromSplashScreen"
    }
}
