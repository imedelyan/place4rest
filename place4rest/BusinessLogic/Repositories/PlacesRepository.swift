//
//  PlacesRepository.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/28/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import RealmSwift

final class PlacesRepository {

    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    func save(places: [Place]) {
        let placesToDelete = realm.objects(Place.self).filter("NOT (id IN %@)", places.map({ $0.id }))
        try? realm.write {
            realm.delete(placesToDelete)
            realm.add(places, update: true)
        }
    }

    func fetchAllPlaces() -> [Place] {
        // TODO: filter draft places
        return Array(realm.objects(Place.self))
    }

    func filterPlaces(categories: Set<Category>, for categoriesFor: Set<CategoryFor>) -> [Place] {
        guard !categories.isEmpty || !categoriesFor.isEmpty else { return fetchAllPlaces() }
        return fetchAllPlaces().filter {
            !Set($0.categories).isDisjoint(with: categories.map { $0.rawValue }) ||
            !Set($0.categoriesFor).isDisjoint(with: categoriesFor.map { $0.rawValue })
        }
    }

    func searchPlaces(by word: String) -> [Place] {
        return realm.objects(Place.self).filter { $0.title.contains(word) || $0.content.contains(word) }
    }

    func fetchPlace(id: Int) -> Place? {
        return realm.objects(Place.self).first(where: { $0.id == id })
    }
}
