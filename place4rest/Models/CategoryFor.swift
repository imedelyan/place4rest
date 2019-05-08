//
//  CategoryFor.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

enum CategoryFor: Int, ImagePresentable, CaseIterable {
    case motorhome = 7
    case cars = 8
    case hiking = 9
    case unknown = 0

    var image: UIImage {
        switch self {
        case .motorhome:
            return #imageLiteral(resourceName: "trailer")
        case .cars:
            return #imageLiteral(resourceName: "sedan")
        case .hiking:
            return #imageLiteral(resourceName: "trekking")
        case .unknown:
            return #imageLiteral(resourceName: "parking")
        }
    }

    var color: UIColor? {
        return R.color.orange()
    }

    var name: String {
        switch self {
        case .motorhome:
            return R.string.localizable.camper()
        case .cars:
            return R.string.localizable.car()
        case .hiking:
            return R.string.localizable.hiker()
        case .unknown:
            return ""
        }
    }
}
