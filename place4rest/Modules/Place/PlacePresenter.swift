//
//  PlacePresenter.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/13/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Foundation

final class PlacePresenter {

    typealias Props = PlaceViewController.Props

    // MARK: - Dependencies
    weak var view: PlaceView!
    var place: Place!

    // MARK: - Variables

    // MARK: - Init
    init() {

    }

    // MARK: - MapView
    func viewWasLoaded() {
        view.render(props: makeProps())
    }
}

// MARK: - Props Factory
extension PlacePresenter {
    private func makeProps() -> Props {
        var categories: [ImagePresentable] = []
        categories.append(contentsOf: Array(place.categories).map { Category(rawValue: $0) ?? .unknown })
        categories.append(contentsOf: Array(place.categoriesFor).map { CategoryFor(rawValue: $0) ?? .unknown })
        categories.append(contentsOf: Array(place.services).map { Service(rawValue: $0) ?? .unknown })
        categories.append(contentsOf: Array(place.activities).map { Activity(rawValue: $0) ?? .unknown })

        return Props(
            title: place.title,
            images: Array(place.images),
            categories: categories,
            text: place.content
        )
    }
}
