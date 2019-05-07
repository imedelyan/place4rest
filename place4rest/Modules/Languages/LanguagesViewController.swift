//
//  LanguagesViewController.swift
//  place4rest
//
//  Created by Igor Medelian on 5/7/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class LanguagesViewController: UIViewController {

    var onSetAction: ((AppLanguage) -> Void)?

    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func didTapUAButton(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            self?.onSetAction?(.ukrainian)
        }
    }

    @IBAction func didTapUKButton(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            self?.onSetAction?(.english)
        }
    }

    @IBAction func didTapRUButton(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            self?.onSetAction?(.russian)
        }
    }
}
