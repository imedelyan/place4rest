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
            return #imageLiteral(resourceName: "fontain")
        case .bike:
            return #imageLiteral(resourceName: "fontain")
        case .viewpoint:
            return #imageLiteral(resourceName: "fontain")
        case .kayak:
            return #imageLiteral(resourceName: "fontain")
        case .playground:
            return #imageLiteral(resourceName: "fontain")
        case .fishing:
            return #imageLiteral(resourceName: "fontain")
        case .moto:
            return #imageLiteral(resourceName: "fontain")
        case .monuments:
            return #imageLiteral(resourceName: "fontain")
        case .trekking:
            return #imageLiteral(resourceName: "fontain")
        case .paragliding:
            return #imageLiteral(resourceName: "fontain")
        case .unknown:
            return #imageLiteral(resourceName: "fontain")
        }
    }
}
