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
            return #imageLiteral(resourceName: "fontain")
        case .lpg:
            return #imageLiteral(resourceName: "fontain")
        case .internet3G:
            return #imageLiteral(resourceName: "fontain")
        case .wifi:
            return #imageLiteral(resourceName: "fontain")
        case .showers:
            return #imageLiteral(resourceName: "fontain")
        case .washingMotorhomes:
            return #imageLiteral(resourceName: "fontain")
        case .trashCan:
            return #imageLiteral(resourceName: "fontain")
        case .toilets:
            return #imageLiteral(resourceName: "fontain")
        case .water:
            return #imageLiteral(resourceName: "fontain")
        case .bakery:
            return #imageLiteral(resourceName: "fontain")
        case .unknown:
            return #imageLiteral(resourceName: "fontain")
        }
    }
}
