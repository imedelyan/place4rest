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
    var navigator: AddPlaceNavigator!
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

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }

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
            break
//            showSpinner()
        case .loggedIn:
//            hideSpinner()
            navigator.navigate(to: .chooseCategory)
        case let .failed(error):
//            hideSpinner()
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
