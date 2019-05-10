//
//  LoginPresenter.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/6/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Foundation

protocol LoginDelegate: class {
    func showSpinner()
    func hideSpinner()
    func navigateToHomeScreen()
    func showLoginError(message: String)
}

class LoginPresenter {

    weak var delegate: LoginDelegate?

    // MARK: - Dependencies
    private let loginService: LoginService

    init(loginService: LoginService) {
        self.loginService = loginService
    }

    // MARK: - Login
    func login(user: String, pass: String) {
        guard fieldsPassedValidation(user: user, pass: pass) else { return }

        delegate?.showSpinner()
        loginService.login(user: user, pass: pass)
            .done { [weak self] in
                self?.delegate?.navigateToHomeScreen()
            }.catch { [weak self] error in
                self?.delegate?.showLoginError(message: error.responseDescription)
            }.finally { [weak self] in
                self?.delegate?.hideSpinner()
        }
    }

    // MARK: - Validation
    private func fieldsPassedValidation(user: String, pass: String) -> Bool {
        guard !user.isEmpty else {
            delegate?.showLoginError(message: "Error.UsernameEmpty".localized())
            return false
        }
        guard !pass.isEmpty else {
            delegate?.showLoginError(message: "Error.PasswordEmpty".localized())
            return false
        }
        return true
    }
}
