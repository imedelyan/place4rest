//
//  AddInfoViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/4/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class AddInfoViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var submitButton: UIButton!

    // MARK: - Dependencies
    var navigator: AddPlaceNavigator!
    var place = Place()

    // MARK: - Variables

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - IBAction
    @IBAction func didTapSubmitButton(_ sender: Any) {
        navigator.backToRoot()
    }
}
