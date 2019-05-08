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
            return R.string.localizable.windsurfing()
        case .bike:
            return R.string.localizable.cycling()
        case .viewpoint:
            return R.string.localizable.viewpoint()
        case .kayak:
            return R.string.localizable.kayak()
        case .playground:
            return R.string.localizable.playground()
        case .fishing:
            return R.string.localizable.fishing()
        case .moto:
            return R.string.localizable.motorcycling()
        case .monuments:
            return R.string.localizable.monuments()
        case .trekking:
            return R.string.localizable.trekking()
        case .paragliding:
            return R.string.localizable.paragliding()
        case .beach:
            return R.string.localizable.beach()
        case .climbing:
            return R.string.localizable.climbing()
        case .unknown:
            return ""
        }
    }
}
