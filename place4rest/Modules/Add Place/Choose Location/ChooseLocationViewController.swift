//
//  ChooseLocationViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/4/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class ChooseLocationViewController: UIViewController {

    // MARK: - IBOutlet

    // MARK: - Dependencies
    var navigator: AddPlaceNavigator!
    var place = Place()

    // MARK: - Variables

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - IBAction
    @IBAction func didTapContinueButton(_ sender: Any) {
        navigator.navigate(to: .addInfo(place: place))
    }
}
