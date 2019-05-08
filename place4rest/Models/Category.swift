//
//  Category.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

enum Category: Int, ImagePresentable, CaseIterable {

    case wildnights = 4
    case springs = 5
    case castles = 6
    case camping = 72
    case nightparking = 76

    case wildnightsEn = 71 // TODO: remove these duplicating values for en from backend side
    case springsEn = 40
    case castlesEn = 39
    case campingEn = 73
    case nightparkingEn = 77

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

        case .wildnightsEn:
            return #imageLiteral(resourceName: "forest")
        case .springsEn:
            return #imageLiteral(resourceName: "fountain")
        case .castlesEn:
            return #imageLiteral(resourceName: "palace")
        case .campingEn:
            return #imageLiteral(resourceName: "camping-tent")
        case .nightparkingEn:
            return #imageLiteral(resourceName: "parking")

        case .unknown:
            return #imageLiteral(resourceName: "parking")
        }
    }

    var color: UIColor? {
        return R.color.blue()
    }

    var name: String {
        switch self {
        case .wildnights:
            return R.string.localizable.wildPlaces()
        case .springs:
            return R.string.localizable.springs()
        case .castles:
            return R.string.localizable.castles()
        case .camping:
            return R.string.localizable.camping()
        case .nightparking:
            return R.string.localizable.parkingForNight()

        case .wildnightsEn:
            return R.string.localizable.wildPlaces()
        case .springsEn:
            return R.string.localizable.springs()
        case .castlesEn:
            return R.string.localizable.castles()
        case .campingEn:
            return R.string.localizable.camping()
        case .nightparkingEn:
            return R.string.localizable.parkingForNight()

        case .unknown:
            return ""
        }
    }
}
