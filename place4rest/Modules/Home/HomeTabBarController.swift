//
//  HomeViewController.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

    var mapNavigator: MapNavigator!
    var searchNavigator: SearchNavigator!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [mapNavigator.navigationController,
                           searchNavigator.navigationController,
                           AddPlaceViewController.load(from: .addPlace),
                           AnnouncementsViewController.load(from: .announcements),
                           SettingsViewController.load(from: .settings)]
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
