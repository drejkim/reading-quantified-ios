//
//  SwinjectStoryboardSetup.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 3/31/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    @objc class func setup() {
        
        // Disable logging for unregistered view controllers
        // See https://github.com/Swinject/Swinject/issues/213
        Container.loggingFunction = nil
        
        // MARK: - View Controller Injections
        
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(LoginViewModel.self)
        }
        
        // MARK: - View Model Injections
        
        defaultContainer.register(LoginViewModel.self) { resolver in
            LoginViewModel(session: resolver.resolve(SessionService.self)!)
        }
        
        // MARK: - App Component Injections
        
        defaultContainer.register(SessionService.self) { _ in
            SessionService()
        }.inObjectScope(.container)
    }
    
}
