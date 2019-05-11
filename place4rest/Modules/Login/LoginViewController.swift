//
//  LoginViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/5/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - Dependencies
    var navigator: LoginNavigator!
    var presenter: LoginPresenter!

    // MARK: - Variables
    private var props = Props(
        state: .initial,
        didTapLoginButton: .nop
    )

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewWasLoaded()
        hideKeyboardWhenTappedAround()
    }

    // MARK: - IBAction
    @IBAction private func loginButtonAction(_ sender: Any) {
        props.didTapLoginButton.perform(with: (usernameTextField.text!, passwordTextField.text!))
    }

    @IBAction private func forgotPasswordButtonAction(_ sender: Any) {

    }

    @IBAction private func registerButtonAction(_ sender: Any) {

    }
}

// MARK: - MapView
protocol LoginView: class {
    func render(props: LoginViewController.Props)
}

extension LoginViewController: LoginView {
    func render(props: Props) {
        self.props = props

        switch props.state {
        case .initial:
            break
        case .loading:
            Loader.show()
        case .loggedIn:
            Loader.hide()
            navigator.dismiss()
        case let .failed(error):
            Loader.hide()
            showError(title: nil, message: error)
        }
    }
}

// MARK: - Props
extension LoginViewController {
    struct Props {
        let state: State; enum State {
            case initial
            case loading
            case loggedIn
            case failed(error: String)
        }
        let didTapLoginButton: CommandWith<(String, String)>
    }
}
