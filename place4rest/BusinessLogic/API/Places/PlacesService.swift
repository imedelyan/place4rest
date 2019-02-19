//
//  PlacesService.swift
//  place4rest
//
//  Created by Igor Medelian on 2/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Moya
import PromiseKit

protocol PlacesService: class {
    func getAllPlaces() -> Promise<[Place]>
    func getPlace(id: Int) -> Promise<Place>
}

final class PlacesServiceProvider: PlacesService {

    private let api: MoyaProvider<PlacesAPI>

    init(api: MoyaProvider<PlacesAPI>) {
        self.api = api
    }

    func getAllPlaces() -> Promise<[Place]> {
        return api
            .request(.getAllPlaces)
            .decode(to: [Place].self)
    }

    func getPlace(id: Int) -> Promise<Place> {
        return api
            .request(.getPlace(id: id))
            .decode(to: Place.self)
    }
}
