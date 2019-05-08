//
//  UtilitiesServicesAssembly.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Swinject

class UtilitiesServicesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(StorageService.self) { _ in
            return StorageServiceProvider(defaults: .standard)
        }
    }
}
