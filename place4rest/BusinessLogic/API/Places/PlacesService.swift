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
    func getPlaces(categories: [Category], for: [CategoryFor]) -> Promise<[Place]>
    func getPlace(id: Int) -> Promise<Place>
    func add(place: Place) -> Promise<Void>
    // http://place4rest.com/wp-json/wp/v2/comments?post=131
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

    func getPlaces(categories: [Category], for categoriesFor: [CategoryFor]) -> Promise<[Place]> {
        return api
            .request(.getPlaces(categories: categories, for: categoriesFor))
            .decode(to: [Place].self)
    }

    func getPlace(id: Int) -> Promise<Place> {
        return api
            .request(.getPlace(id: id))
            .decode(to: Place.self)
    }

    func add(place: Place) -> Promise<Void> {
        return api
            .request(.add(place: place, token: "token"))
            .asVoid()
    }
}
