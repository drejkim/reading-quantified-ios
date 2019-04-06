//
//  LoginViewController.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 3/30/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var viewModel: LoginViewModel!
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - IB Outlets & Actions
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginStatusLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        viewModel.validateCredentials(inputUsername: usernameTextField.text, inputPassword: passwordTextField.text)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.status.asObservable()
            .subscribe(onNext: { [weak self] loginStatus in
                guard let strongSelf = self else { return }
                
                strongSelf.loginStatusLabel.text = strongSelf.viewModel.getStatusMessage(status: loginStatus)
                strongSelf.loginButton.isHidden = strongSelf.viewModel.hideLoginButton(status: loginStatus)
                
                if loginStatus == .valid {
                    strongSelf.performSegue(withIdentifier: Constants.SegueIdentifiers.mainStoryboard, sender: strongSelf)
                }
            })
            .disposed(by: bag)
    }

}

