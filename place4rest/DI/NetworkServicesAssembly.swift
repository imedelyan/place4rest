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
            return PlacesServiceProvider(api: provider!)
        }
    }
}
