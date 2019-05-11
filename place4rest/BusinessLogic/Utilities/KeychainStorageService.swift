//
//  KeychainStorageService.swift
//  place4rest
//
//  Created by Igor Medelian on 5/10/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import KeychainSwift

public protocol KeychainStorageService: class {
    var token: String { get set }
    func clearToken()
}

public final class KeychainStorageServiceProvider: KeychainStorageService {

    private let keychain: KeychainSwift

    private let tokenKey = "token"

    public var token: String {
        set { keychain.set(newValue, forKey: tokenKey) }
        get { return keychain.get(tokenKey) ?? "" }
    }

    init(keychain: KeychainSwift) {
        self.keychain = keychain
    }

    public func clearToken() {
        keychain.delete(tokenKey)
    }
}
