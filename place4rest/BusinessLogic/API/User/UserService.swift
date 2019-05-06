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
    func login(email: String, password: String) -> Promise<User>
}

final class UserServiceProvider: UserService {
    
    private var api: MoyaProvider<UserAPI>
    
    private var apiTokenStore: ApiTokenCodableKeychainStore
    private var userStore: UserCodableKeychainStore
    
    init(api: MoyaProvider<AuthorizationApi>, apiTokenStore: ApiTokenCodableKeychainStore, userStore: UserCodableKeychainStore) {
        self.api = api
        self.apiTokenStore = apiTokenStore
        self.userStore = userStore
    }
    
    func login(email: String, password: String) -> Promise<User> {
        let target: AuthorizationApi = .login(email: email, password: password)
        return api.request(target).compactMap(on: .global(), { response in
            let token = try response.map(AuthToken.self)
            let user = try response.map(User.self)
            self.apiTokenStore.data = token
            self.userStore.data = user
            return user
        })
    }
}
