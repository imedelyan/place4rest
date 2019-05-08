//
//  RoundedButton.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/12/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    @IBInspectable var radius: CGFloat = 3.0

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
