//
//  StorageServicesAssembly.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/29/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import RealmSwift
import Swinject

class StorageServicesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(RealmFactory.self, factory: { _ in
            return RealmFactory()
        }).inObjectScope(.container)
        container.register(PlacesRepository.self) { resolver in
            let realm = resolver.resolve(RealmFactory.self)?.makeRealm()
            return PlacesRepository(realm: realm!)
        }
    }
}

final class RealmFactory {
    func makeRealm() -> Realm? {
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        return try? Realm(configuration: config)
    }
}
