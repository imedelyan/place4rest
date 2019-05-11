//
//  LoginPresenter.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/6/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Foundation

class LoginPresenter {

    typealias Props = LoginViewController.Props

    // MARK: - Dependencies
    private let userService: UserService
    weak var view: LoginView!

    // MARK: - Variables
    private var state: Props.State = .initial {
        didSet {
            view.render(props: self.makeProps())
        }
    }

    // MARK: - Init
    init(userService: UserService) {
        self.userService = userService
    }

    // MARK: - SearchView
    func viewWasLoaded() {
        view.render(props: self.makeProps())
    }

    // MARK: - Login
    func login(username: String, password: String) {
        guard fieldsPassedValidation(username: username, password: password) else { return }

        state = .loading
//        userService.getToken(username: username, password: password)
        userService.getToken(username: "imedelyan", password: "de1q9NsG(MlvqKL(iwA2$hjh")
            .done { [weak self] in
                self?.state = .loggedIn
            }.catch { [weak self] error in
                self?.state = .failed(error: error.localizedDescription)
            }
    }

    // MARK: - Validation
    private func fieldsPassedValidation(username: String, password: String) -> Bool {
        guard !username.isEmpty else {
            state = .failed(error: "Error.UsernameEmpty".localized())
            return false
        }
        guard !password.isEmpty else {
            state = .failed(error: "Error.PasswordEmpty".localized())
            return false
        }
        return true
    }
}

// MARK: - Props Factory
extension LoginPresenter {
    private func makeProps() -> Props {
        return Props(state: state,
                     didTapLoginButton: CommandWith(action: { [weak self] (username, password) in
                        self?.login(username: username, password: password)
                     }))
    }
}
