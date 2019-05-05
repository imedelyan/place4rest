//
//  Service.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

enum Service: Int, ImagePresentable, CaseIterable {
    case pool = 10
    case lpg = 11
    case internet3G = 12
    case wifi = 13
    case showers = 14
    case dog = 15
    case washingMotorhomes = 16
    case trashCan = 17
    case toilets = 18
    case water = 19
    case laundromat = 20
    case blackWater = 21
    case usedWater = 22
    case bakery = 23
    case electricity = 24
    case unknown = 0

    var image: UIImage {
        switch self {
        case .pool:
            return #imageLiteral(resourceName: "swimming-pool")
        case .lpg:
            return #imageLiteral(resourceName: "gas-station")
        case .internet3G:
            return #imageLiteral(resourceName: "iphone")
        case .wifi:
            return #imageLiteral(resourceName: "wi-fi")
        case .showers:
            return #imageLiteral(resourceName: "shower")
        case .washingMotorhomes:
            return #imageLiteral(resourceName: "automatic-car-wash")
        case .trashCan:
            return #imageLiteral(resourceName: "waste")
        case .toilets:
            return #imageLiteral(resourceName: "toilet")
        case .water:
            return #imageLiteral(resourceName: "plumbing")
        case .bakery:
            return #imageLiteral(resourceName: "bread")
        case .dog:
            return #imageLiteral(resourceName: "pets")
        case .laundromat:
            return #imageLiteral(resourceName: "washing-machine")
        case .blackWater:
            return #imageLiteral(resourceName: "sewer")
        case .usedWater:
            return #imageLiteral(resourceName: "water-pipe")
        case .electricity:
            return #imageLiteral(resourceName: "electrical")
        case .unknown:
            return #imageLiteral(resourceName: "parking")
        }
    }

    var color: UIColor? {
        return R.color.dark_blue()
    }

    var name: String {
        switch self {
        case .pool:
            return "Pool"
        case .lpg:
            return "Liquefied petroleum gas"
        case .internet3G:
            return "Internet 3G"
        case .wifi:
            return "WiFi"
        case .showers:
            return "Showers"
        case .dog:
            return "Pet walking"
        case .washingMotorhomes:
            return "Camper, car washing"
        case .trashCan:
            return "Trashcan"
        case .toilets:
            return "Toilets"
        case .water:
            return "Water"
        case .laundromat:
            return "Laundry"
        case .blackWater:
            return "Blackwater disposal"
        case .usedWater:
            return "Wastewater disposal"
        case .bakery:
            return "Bakery"
        case .electricity:
            return "Power supply"
        case .unknown:
            return ""
        }
    }
}
