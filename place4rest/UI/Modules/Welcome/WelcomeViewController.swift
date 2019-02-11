//
//  WelcomeViewController.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var navigator: Navigator!
    var storageService: StorageService!

    override func viewDidLoad() {
        super.viewDidLoad()

        storageService.isAppAlreadyLoaded = true
        navigator.navigate(to: .home)
    }
}
