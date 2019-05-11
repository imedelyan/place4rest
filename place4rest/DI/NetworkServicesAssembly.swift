//
//  NetworkServicesAssembly.swift
//  place4rest
//
//  Created by Igor Medelian on 2/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Swinject

class NetworkServicesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(PlacesService.self) { resolver in
            let provider = resolver.resolve(MoyaProvidersFactory.self)?.make(PlacesAPI.self)
            let keychainStorageService = resolver.resolve(KeychainStorageService.self)
            return PlacesServiceProvider(api: provider!, storageService: keychainStorageService!)
        }
        container.register(UserService.self) { resolver in
            let provider = resolver.resolve(MoyaProvidersFactory.self)?.make(UserAPI.self)
            let keychainStorageService = resolver.resolve(KeychainStorageService.self)
            return UserServiceProvider(api: provider!, storageService: keychainStorageService!)
        }
    }
}
