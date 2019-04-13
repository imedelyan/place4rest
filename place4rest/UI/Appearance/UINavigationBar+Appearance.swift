//
//  UINavigationBar+Appearance.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/13/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func setupDefaultTheme() {
        barTintColor = R.color.dark_gray()
        tintColor = .white

        titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
    }
}
