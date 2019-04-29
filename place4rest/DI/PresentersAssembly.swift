//
//  PresentersAssembly.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Swinject

class PresentersAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MapPresenter.self) { resolver in
            let placesService = resolver.resolve(PlacesService.self)
            let placesRepository = resolver.resolve(PlacesRepository.self)
            return MapPresenter(placesService: placesService!, placesRepository: placesRepository!)
        }
        container.register(PlacePresenter.self) { _ in
            return PlacePresenter()
        }
    }
}
