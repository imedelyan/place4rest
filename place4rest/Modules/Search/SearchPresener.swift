//
//  SearchPresener.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/1/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import PromiseKit

final class SearchPresenter: NSObject {

    typealias Props = SearchViewController.Props

    // MARK: - Dependencies
    private let placesRepository: PlacesRepository
    weak var view: SearchView!

    // MARK: - Variables
    private var foundPlaces: [Place] = []

    // MARK: - Init
    init(placesRepository: PlacesRepository) {
        self.placesRepository = placesRepository
    }

    // MARK: - SearchView
    func viewWasLoaded() {
        view.render(props: self.makeProps())
    }
}

// MARK: - Props Factory
extension SearchPresenter {
    private func makeProps() -> Props {
        return Props(didReceiveTextForSearch: CommandWith(action: { [weak self] text in
                        guard let self = self else { return }
                        self.foundPlaces = self.placesRepository.searchPlaces(by: text)
                        self.view?.render(props: self.makeProps())
                     }),
                     foundPlaces: foundPlaces)
    }
}
