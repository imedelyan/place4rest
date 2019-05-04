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
            break
        case .chooseServices:
            break
        case .chooseLocation:
            break
        case .addInfo:
            break
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
        case chooseServices
        case chooseLocation
        case addInfo
    }
}
