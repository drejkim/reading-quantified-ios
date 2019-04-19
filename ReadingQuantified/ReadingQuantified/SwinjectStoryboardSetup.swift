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
        
        defaultContainer.storyboardInitCompleted(BooksViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(BooksViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(LoginViewModel.self)
        }
        
        // MARK: - View Model Injections
        
        defaultContainer.register(BooksViewModel.self) { resolver in
            BooksViewModel(session: resolver.resolve(Session.self)!)
        }
        
        defaultContainer.register(LoginViewModel.self) { resolver in
            LoginViewModel(session: resolver.resolve(Session.self)!)
        }
        
        // MARK: - App Component Injections
        
        defaultContainer.register(Session.self) { _ in
            Session()
        }.inObjectScope(.container)
    }
    
}
