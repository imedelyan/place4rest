//
//  UIViewController+Extension.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/1/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func showError(title: String?, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: R.string.localizable.ok(), style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
