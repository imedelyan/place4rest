//
//  CategoryFor.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

enum CategoryFor: Int, ImagePresentable {
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
}
