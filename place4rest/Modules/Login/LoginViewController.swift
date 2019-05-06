//
//  LoginViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/5/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class LoginViewController: ViewControllerWithSpinner {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: - Dependencies
    var navigator: Navigator!
    var presenter: LoginPresenter!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        usernameTextField
            .add(nextResponder: passwordTextField)
            .add(nextResponder: view)
        addGestureRecognizerToHideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - IBAction
    @IBAction private func loginButtonAction(_ sender: Any) {
        presenter.login(user: usernameTextField.text!, pass: passwordTextField.text!)
    }
    
    @IBAction private func forgotPasswordButtonAction(_ sender: Any) {
        navigator.navigate(to: .forgotPassword(step: .selectMethod))
    }
    
    @IBAction private func registerButtonAction(_ sender: Any) {
        navigator.navigate(to: .signup(step: .tutorial))
    }
}

extension LoginViewController: LoginDelegate {
    func navigateToHomeScreen() {
        navigator.navigate(to: .home)
    }
    
    func showLoginError(message: String) {
        showError(title: nil, message: message)
    }
}
