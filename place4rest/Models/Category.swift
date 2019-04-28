//
//  Category.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

enum Category: Int, ImagePresentable {
    case wildnights = 4
    case springs = 5
    case castles = 6
    case camping = 72
    case nightparking = 76
    case unknown = 0

    var image: UIImage {
        switch self {
        case .wildnights:
            return #imageLiteral(resourceName: "forest")
        case .springs:
            return #imageLiteral(resourceName: "fountain")
        case .castles:
            return #imageLiteral(resourceName: "palace")
        case .camping:
            return #imageLiteral(resourceName: "camping-tent")
        case .nightparking:
            return #imageLiteral(resourceName: "parking")
        case .unknown:
            return #imageLiteral(resourceName: "parking")
        }
    }

    var color: UIColor? {
        return R.color.blue()
    }
}
