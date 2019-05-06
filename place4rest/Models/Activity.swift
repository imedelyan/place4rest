//
//  Activity.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

enum Activity: Int, ImagePresentable, CaseIterable {
    case windsurf = 25
    case bike = 26
    case viewpoint = 27
    case kayak = 28
    case playground = 29
    case fishing = 30
    case moto = 31
    case monuments = 32
    case trekking = 33
    case beach = 34
    case climbing = 35
    case paragliding = 74
    case unknown = 0

    var image: UIImage {
        switch self {
        case .windsurf:
            return #imageLiteral(resourceName: "windsurfing")
        case .bike:
            return #imageLiteral(resourceName: "cycling")
        case .viewpoint:
            return #imageLiteral(resourceName: "telescope")
        case .kayak:
            return #imageLiteral(resourceName: "canoe")
        case .playground:
            return #imageLiteral(resourceName: "playground")
        case .fishing:
            return #imageLiteral(resourceName: "fishing-pole")
        case .moto:
            return #imageLiteral(resourceName: "motorcycle")
        case .monuments:
            return #imageLiteral(resourceName: "monument")
        case .trekking:
            return #imageLiteral(resourceName: "trekking")
        case .paragliding:
            return #imageLiteral(resourceName: "paragliding")
        case .beach:
            return #imageLiteral(resourceName: "beach-umbrella.png")
        case .climbing:
            return #imageLiteral(resourceName: "climbing.png")
        case .unknown:
            return #imageLiteral(resourceName: "parking")
        }
    }

    var color: UIColor? {
        return R.color.dark_green()
    }

    var name: String {
        switch self {
        case .windsurf:
            return "Windsurfing"
        case .bike:
            return "Cycling"
        case .viewpoint:
            return "Viewpoint"
        case .kayak:
            return "Kayak"
        case .playground:
            return "Playground"
        case .fishing:
            return "Fishing"
        case .moto:
            return "Motorcycling"
        case .monuments:
            return "Monuments"
        case .trekking:
            return "Trekking"
        case .paragliding:
            return "Paragliding"
        case .beach:
            return "Beach"
        case .climbing:
            return "Climbing"
        case .unknown:
            return ""
        }
    }
}
