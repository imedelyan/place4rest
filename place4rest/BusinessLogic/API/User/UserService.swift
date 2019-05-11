//
//  AuthorizationService.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/5/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Moya
import PromiseKit

protocol UserService: class {
    func getToken(username: String, password: String) -> Promise<Void>
    func login(username: String, password: String) -> Promise<User>
    func getUser() -> Promise<User>
    func update(username: String, name: String, email: String) -> Promise<User>
    func updatePassword(newPassword: String, oldPassword: String) -> Promise<User>
    func logout() -> Promise<Void>
}

final class UserServiceProvider: UserService {

    private let api: MoyaProvider<UserAPI>
    private let storageService: KeychainStorageService

    init(api: MoyaProvider<UserAPI>, storageService: KeychainStorageService) {
        self.api = api
        self.storageService = storageService
    }

    func getToken(username: String, password: String) -> Promise<Void> {
        return api
            .request(.getToken(username: username, password: password))
            .decode(to: String.self, atKeyPath: "token")
            .done { [weak self] in
                self?.storageService.token = $0
        }
    }

    func login(username: String, password: String) -> Promise<User> {
        return api
            .request(.login(username: username, password: password))
            .decode(to: User.self)
    }

    func getUser() -> Promise<User> {
        return api
            .request(.getUser(token: storageService.token))
            .decode(to: User.self)
    }

    func update(username: String, name: String, email: String) -> Promise<User> {
        return api
            .request(.update(username: username, name: name, email: email, token: storageService.token))
            .decode(to: User.self)
    }

    func updatePassword(newPassword: String, oldPassword: String) -> Promise<User> {
        return api
            .request(.updatePassword(newPassword: newPassword, oldPassword: oldPassword, token: storageService.token))
            .decode(to: User.self)
    }

    func logout() -> Promise<Void> {
        return api
            .request(.logout(token: storageService.token))
            .asVoid()
    }
}
