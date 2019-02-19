//
//  NetworkAPIsAssembly.swift
//  place4rest
//
//  Created by Igor Medelian on 2/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Moya
import Swinject

class NetworkAPIsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MoyaProvidersFactory.self, factory: { resolver in
            return MoyaProvidersFactory(debugPlugins: [NetworkLoggerPlugin(verbose: true)])
        }).inObjectScope(.container)
    }
}

final class MoyaProvidersFactory {
    
    private let debugPlugins: [PluginType]
    
    init(debugPlugins: [PluginType]) {
        self.debugPlugins = debugPlugins
    }
    
    func make<T: TargetType>(_ type: T.Type) -> MoyaProvider<T> {
        var pluginsToAdd: [PluginType] = []
        #if DEBUG
        pluginsToAdd.append(contentsOf: debugPlugins)
        #endif
        return MoyaProvider<T>(plugins: pluginsToAdd)
    }
}
