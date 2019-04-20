//
//  Service.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

enum Service: Int, ImagePresentable {
    case pool = 10
    case lpg = 11
    case internet3G = 12
    case wifi = 13
    case showers = 14
    case washingMotorhomes = 16
    case trashCan = 17
    case toilets = 18
    case water = 19
    case bakery = 23
    case unknown = 0

    var image: UIImage {
        switch self {
        case .pool:
            return #imageLiteral(resourceName: "parking")
        case .lpg:
            return #imageLiteral(resourceName: "parking")
        case .internet3G:
            return #imageLiteral(resourceName: "parking")
        case .wifi:
            return #imageLiteral(resourceName: "parking")
        case .showers:
            return #imageLiteral(resourceName: "parking")
        case .washingMotorhomes:
            return #imageLiteral(resourceName: "parking")
        case .trashCan:
            return #imageLiteral(resourceName: "parking")
        case .toilets:
            return #imageLiteral(resourceName: "parking")
        case .water:
            return #imageLiteral(resourceName: "parking")
        case .bakery:
            return #imageLiteral(resourceName: "parking")
        case .unknown:
            return #imageLiteral(resourceName: "parking")
        }
    }

    var color: UIColor? {
        return R.color.dark_blue()
    }
}
