//
//  Activity.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

enum Activity: Int, ImagePresentable {
    case windsurf = 25
    case bike = 26
    case viewpoint = 27
    case kayak = 28
    case playground = 29
    case fishing = 30
    case moto = 31
    case monuments = 32
    case trekking = 33
    case paragliding = 74
    case unknown = 0

    var image: UIImage {
        switch self {
        case .windsurf:
            return #imageLiteral(resourceName: "parking")
        case .bike:
            return #imageLiteral(resourceName: "parking")
        case .viewpoint:
            return #imageLiteral(resourceName: "parking")
        case .kayak:
            return #imageLiteral(resourceName: "parking")
        case .playground:
            return #imageLiteral(resourceName: "parking")
        case .fishing:
            return #imageLiteral(resourceName: "parking")
        case .moto:
            return #imageLiteral(resourceName: "parking")
        case .monuments:
            return #imageLiteral(resourceName: "parking")
        case .trekking:
            return #imageLiteral(resourceName: "parking")
        case .paragliding:
            return #imageLiteral(resourceName: "parking")
        case .unknown:
            return #imageLiteral(resourceName: "parking")
        }
    }

    var color: UIColor? {
        return R.color.green()
    }
}
