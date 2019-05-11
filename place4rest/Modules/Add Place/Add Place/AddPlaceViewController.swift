//
//  AddPlaceViewController.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class AddPlaceViewController: UIViewController {

    // MARK: - Dependencies
    var navigator: AddPlaceNavigator!

    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - IBAction
    @IBAction func didTapAddPlaceButton(_ sender: Any) {
        navigator.start()
    }
}
