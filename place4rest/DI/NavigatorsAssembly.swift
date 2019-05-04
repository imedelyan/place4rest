//
//  NavigatorsAssembly.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Swinject

class NavigatorsAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AppNavigator.self, factory: { resolver in
            let storageService = resolver.resolve(StorageService.self)
            return AppNavigator(storageService: storageService!)
        }).inObjectScope(.container)
        container.register(MapNavigator.self, factory: { _ in
            return MapNavigator()
        })
        container.register(SearchNavigator.self, factory: { _ in
            return SearchNavigator()
        })
        container.register(AddPlaceNavigator.self, factory: { _ in
            return AddPlaceNavigator()
        })
    }
}
