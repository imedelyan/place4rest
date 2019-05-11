//
//  StorageService.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Foundation

public protocol DefaultsStorageService: class {
    var isAppAlreadyLoaded: Bool { get set }
}

public final class DefaultsStorageServiceProvider: DefaultsStorageService {

    let defaults: UserDefaults
    private let alreadyLoadedKey = "com.place4rest.alreadyLoaded"

    public var isAppAlreadyLoaded: Bool {
        set { defaults.set(newValue, forKey: alreadyLoadedKey) }
        get { return defaults.bool(forKey: alreadyLoadedKey) }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}
