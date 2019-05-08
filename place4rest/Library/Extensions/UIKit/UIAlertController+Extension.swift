//
//  UIAlertController+Extension.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/6/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func makeConfirmation(title: String,
                                 message: String,
                                 confirmTitle: String,
                                 cancelTitle: String = R.string.localizable.cancel(),
                                 confirmed: Command,
                                 rejected: (() -> Void)? = nil) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: cancelTitle,
                                           style: .cancel,
                                           handler: { _ in rejected?() }))
        controller.addAction(UIAlertAction(title: confirmTitle,
                                           style: .destructive,
                                           handler: { _ in confirmed.perform() }))
        return controller
    }

    func present(from vc: UIViewController) {
        vc.present(self, animated: true, completion: nil)
    }
}
