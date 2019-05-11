//
//  UtilitiesServicesAssembly.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import KeychainSwift
import Swinject

class UtilitiesServicesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(DefaultsStorageService.self) { _ in
            return DefaultsStorageServiceProvider(defaults: .standard)
        }
        container.register(KeychainStorageService.self) { _ in
            return KeychainStorageServiceProvider(keychain: KeychainSwift())
        }
    }
}
