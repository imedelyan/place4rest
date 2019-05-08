//
//  AppDelegate.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        _ = Assembler([
            NavigatorsAssembly(),
            ViewControllersAssembly(),
            PresentersAssembly(),
            NetworkServicesAssembly(),
            NetworkAPIsAssembly(),
            StorageServicesAssembly(),
            UtilitiesServicesAssembly()
            ], container: defaultContainer)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true
        AppLanguage.startLanguage = AppLanguage.language

        guard let navigator = SwinjectStoryboard.defaultContainer.resolve(AppNavigator.self) else { return true }
        navigator.start()

        return true
    }
}
