//
//  MapNavigator.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/13/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

final class MapNavigator {

    let navigationController: UINavigationController

    // MARK: - Init
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        navigate(to: .map)
    }

    // MARK: - Navigations
    func navigate(to destination: Step) {
        switch destination {
        case .map:
            let vc = MapViewController.load(from: .map)
            vc.navigator = self
            navigationController.pushViewController(vc, animated: true)
        case .place(let place):
            let vc = PlaceViewController.load(from: .place)
            vc.navigator = self
            vc.presenter.place = place
            navigationController.pushViewController(vc, animated: true)
        }
    }

    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}

extension MapNavigator {
    enum Step {
        case map
        case place(_ place: Place)
    }
}
