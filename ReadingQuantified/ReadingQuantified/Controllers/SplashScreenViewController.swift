//
//  SplashScreenViewController.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/20/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashScreenViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var viewModel: SplashScreenViewModel!
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // TEMPORARY: For testing only
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bindUI()
    }
    
    // MARK: - Private Functions
    
    private func bindUI() {
        viewModel.isLoggedIn.asObservable()
            .subscribe(onNext: { [weak self] value in
                guard let strongSelf = self else { return }
                
                if value {
                    strongSelf.performSegue(withIdentifier: Constants.SegueIdentifiers.goToMainFromSplashScreen, sender: strongSelf)
                }
                else {
                    strongSelf.performSegue(withIdentifier: Constants.SegueIdentifiers.goToLoginFromSplashScreen, sender: strongSelf)
                }
            })
            .disposed(by: bag)
    }
    
}
