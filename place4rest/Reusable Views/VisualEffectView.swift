//
//  VisualEffectView.swift
//  place4rest
//
//  Created by Igor Medelian on 2/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class VisualEffectView: UIVisualEffectView {

    @IBInspectable var radius: CGFloat = 3.0

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
