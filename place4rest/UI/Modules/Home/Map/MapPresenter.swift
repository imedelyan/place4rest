//
//  MapPresenter.swift
//  place4rest
//
//  Created by Igor Medelian on 2/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import PromiseKit

final class MapPresenter {

    // MARK: - Dependencies
    private let placesService: PlacesService
    weak var view: MapView!

    init(placesService: PlacesService) {
        self.placesService = placesService
    }

    func viewWasLoaded() {
        view.setLoading(hidden: false)
        placesService
            .getAllPlaces()
            .ensure { [weak self] in
                self?.view.setLoading(hidden: true)
            }.done { [weak self] places in
                self?.view.show(places: places)
            }.catch { [weak self] in
                print($0.localizedDescription)
                self?.view.display(errorMessage: $0.localizedDescription)
        }
    }
}
