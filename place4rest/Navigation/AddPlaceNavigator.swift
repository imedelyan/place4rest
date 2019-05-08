//
//  AddPlaceNavigator.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/4/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

final class AddPlaceNavigator {

    let navigationController: UINavigationController

    // MARK: - Init
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        navigate(to: .addPlace)
    }

    // MARK: - Navigations
    func navigate(to destination: Step) {
        switch destination {
        case .addPlace:
            let vc = AddPlaceViewController.load(from: .addPlace)
            vc.navigator = self
            navigationController.pushViewController(vc, animated: true)
        case .chooseCategory:
            let vc = ChooseCategoryViewController.load(from: .addPlace)
            vc.navigator = self
            navigationController.pushViewController(vc, animated: true)
        case let .chooseServices(place):
            let vc = ChooseServicesViewController.load(from: .addPlace)
            vc.navigator = self
            vc.place = place
            navigationController.pushViewController(vc, animated: true)
        case let .chooseLocation(place):
            let vc = ChooseLocationViewController.load(from: .addPlace)
            vc.navigator = self
            vc.place = place
            navigationController.pushViewController(vc, animated: true)
        case let .addInfo(place):
            let vc = AddInfoViewController.load(from: .addPlace)
            vc.navigator = self
            vc.place = place
            navigationController.pushViewController(vc, animated: true)
        }
    }

    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}

extension AddPlaceNavigator {
    enum Step {
        case addPlace
        case chooseCategory
        case chooseServices(place: Place)
        case chooseLocation(place: Place)
        case addInfo(place: Place)
    }
}
