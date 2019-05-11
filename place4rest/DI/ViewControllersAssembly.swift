//
//  ViewControllersAssembly.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class ViewControllersAssembly: Assembly {

    func assemble(container: Container) {
        container.storyboardInitCompleted(WelcomeViewController.self) { (resolver, controller) in
            controller.navigator = resolver.resolve(AppNavigator.self)
            controller.storageService = resolver.resolve(DefaultsStorageService.self)
        }
        container.storyboardInitCompleted(HomeTabBarController.self) { (resolver, controller) in
            controller.mapNavigator = resolver.resolve(MapNavigator.self)!
            controller.searchNavigator = resolver.resolve(SearchNavigator.self)!
            controller.addPlaceNavigator = resolver.resolve(AddPlaceNavigator.self)!
            controller.settingsNavigator = resolver.resolve(SettingsNavigator.self)!
        }
        container.storyboardInitCompleted(MapViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(MapPresenter.self)
            controller.presenter.view = controller
        }
        container.storyboardInitCompleted(PlaceViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(PlacePresenter.self)
            controller.presenter.view = controller
        }
        container.storyboardInitCompleted(SearchViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(SearchPresenter.self)
            controller.presenter.view = controller
        }
        container.storyboardInitCompleted(AddInfoViewController.self) { (resolver, controller) in
            controller.placesService = resolver.resolve(PlacesService.self)
        }
        container.storyboardInitCompleted(LoginViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(LoginPresenter.self)
            controller.presenter.view = controller
        }
        container.storyboardInitCompleted(SettingsViewController.self) { (resolver, controller) in
            controller.storageService = resolver.resolve(KeychainStorageService.self)
            controller.userService = resolver.resolve(UserService.self)
        }
    }
}
