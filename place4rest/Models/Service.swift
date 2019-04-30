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
    case gpl = 11
    case internet3G = 12
    case wifi = 13
    case showers = 14
    case dog = 15 // Прогулки с домашними животными
    case washingMotorhomes = 16
    case trashCan = 17
    case toilets = 18
    case water = 19
    case laundromat = 20 // Прачечная-автомат
    case blackWater = 21 // Слив туалета
    case usedWater = 22 // Слив сточных вод
    case bakery = 23
    case electricity = 24
    case unknown = 0

    var image: UIImage {
        switch self {
        case .pool:
            return #imageLiteral(resourceName: "swimming-pool")
        case .gpl:
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
            return #imageLiteral(resourceName: "parking")
        case .laundromat:
            return #imageLiteral(resourceName: "parking")
        case .blackWater:
            return #imageLiteral(resourceName: "parking")
        case .usedWater:
            return #imageLiteral(resourceName: "parking")
        case .electricity:
            return #imageLiteral(resourceName: "parking")
        case .unknown:
            return #imageLiteral(resourceName: "parking")
        }
    }

    var color: UIColor? {
        return R.color.dark_blue()
    }
}
