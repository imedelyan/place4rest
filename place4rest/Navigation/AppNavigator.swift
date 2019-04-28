//
//  AppNavigator.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

protocol Navigator: class {
    func start()
    func navigate(to destination: AppStep)
}

enum AppStep {
    case welcome
    case home
}

class AppNavigator: Navigator {

    // MARK: - Properties
    private lazy var window: UIWindow? = {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        return window
    }()
    private lazy var navigationController: UINavigationController = UINavigationController()
    private let storageService: StorageService

    // MARK: - Init
    init(storageService: StorageService) {
        self.storageService = storageService
        self.window?.rootViewController = navigationController
        UINavigationBar.appearance().setupDefaultTheme()
    }

    // MARK: - Navigation methods
    func start() {
        storageService.isAppAlreadyLoaded ? navigate(to: .home) : navigate(to: .welcome)
    }

    func navigate(to destination: AppStep) {
        let vc = makeViewController(for: destination)
        vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        if vc is HomeTabBarController {
            self.window?.rootViewController = vc
        } else {
            navigationController.pushViewController(vc, animated: true)
        }
    }

    private func makeViewController(for destination: AppStep) -> UIViewController {
        switch destination {
        case .welcome:
            return WelcomeViewController.load(from: .welcome)
        case .home:
            return HomeTabBarController.load(from: .home)
        }
    }
}

extension UINavigationBar {
    func setupDefaultTheme() {
        barTintColor = R.color.dark_gray()
        tintColor = .white
        
        titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
    }
}
