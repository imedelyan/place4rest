//
//  UIKit+Localization.swift
//  place4rest
//
//  Created by Igor Medelian on 5/7/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable var localizationIdentifier: String? {
        get { return "" }
        set {
            text = newValue?.localized()
        }
    }
}

extension UITextView {
    @IBInspectable var localizationIdentifier: String? {
        get { return "" }
        set {
            text = newValue?.localized()
        }
    }
}

extension UITextField {
    @IBInspectable var localizationIdentifier: String? {
        get { return "" }
        set {
            placeholder = newValue?.localized()
        }
    }
}

extension UIButton {
    @IBInspectable var localizationIdentifier: String? {
        get { return "" }
        set {
            setTitle(newValue?.localized(), for: .normal)
        }
    }

    @IBInspectable var attributedLocalizationIdentifier: String? {
        get { return "" }
        set {
            let text = newValue!.localized()
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            let titleString = NSAttributedString(string: text,
                                                 attributes: [.foregroundColor: self.tintColor as Any,
                                                              .paragraphStyle: paragraph])
            setAttributedTitle(titleString, for: .normal)
        }
    }
}

extension UINavigationItem {
    @IBInspectable var localizationIdentifier: String? {
        get { return "" }
        set {
            title = newValue?.localized()
        }
    }
}

extension UIBarButtonItem {
    @IBInspectable var localizationIdentifier: String? {
        get { return "" }
        set {
            title = newValue?.localized()
        }
    }
}

extension UISearchBar {
    @IBInspectable var localizationIdentifier: String? {
        get { return ""}
        set {
            placeholder = newValue?.localized()
        }
    }
}
