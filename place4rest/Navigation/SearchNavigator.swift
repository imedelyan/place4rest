//
//  SearchNavigator.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/3/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

final class SearchNavigator {

    let navigationController: UINavigationController

    // MARK: - Init
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        navigate(to: .search)
    }

    // MARK: - Navigations
    func navigate(to destination: Step) {
        switch destination {
        case .search:
            let vc = SearchViewController.load(from: .search)
            vc.navigator = self
            navigationController.pushViewController(vc, animated: true)
        case .place(let place):
            let vc = PlaceViewController.load(from: .place)
            vc.presenter.place = place
            navigationController.pushViewController(vc, animated: true)

        }
    }

    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}

extension SearchNavigator {
    enum Step {
        case search
        case place(_ place: Place)
    }
}
