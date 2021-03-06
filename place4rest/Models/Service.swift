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

    case poolEn = 61 // TODO: remove these duplicating values for en from backend side
    case lpgEn = 62
    case internet3GEn = 63
    case wifiEn = 64
    case showersEn = 65
    case dogEn = 51
    case washingMotorhomesEn = 60
    case trashCanEn = 52
    case toiletsEn = 53
    case waterEn = 54
    case laundromatEn = 67
    case blackWaterEn = 69
    case usedWaterEn = 68
    case bakeryEn = 66
    case electricityEn = 70

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

        case .poolEn:
            return #imageLiteral(resourceName: "swimming-pool")
        case .lpgEn:
            return #imageLiteral(resourceName: "gas-station")
        case .internet3GEn:
            return #imageLiteral(resourceName: "iphone")
        case .wifiEn:
            return #imageLiteral(resourceName: "wi-fi")
        case .showersEn:
            return #imageLiteral(resourceName: "shower")
        case .washingMotorhomesEn:
            return #imageLiteral(resourceName: "automatic-car-wash")
        case .trashCanEn:
            return #imageLiteral(resourceName: "waste")
        case .toiletsEn:
            return #imageLiteral(resourceName: "toilet")
        case .waterEn:
            return #imageLiteral(resourceName: "plumbing")
        case .bakeryEn:
            return #imageLiteral(resourceName: "bread")
        case .dogEn:
            return #imageLiteral(resourceName: "pets")
        case .laundromatEn:
            return #imageLiteral(resourceName: "washing-machine")
        case .blackWaterEn:
            return #imageLiteral(resourceName: "sewer")
        case .usedWaterEn:
            return #imageLiteral(resourceName: "water-pipe")
        case .electricityEn:
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
            return R.string.localizable.pool()
        case .lpg:
            return R.string.localizable.liquefiedPetroleumGas()
        case .internet3G:
            return R.string.localizable.internet3G()
        case .wifi:
            return R.string.localizable.wiFi()
        case .showers:
            return R.string.localizable.showers()
        case .dog:
            return R.string.localizable.petWalking()
        case .washingMotorhomes:
            return R.string.localizable.camperCarWashing()
        case .trashCan:
            return R.string.localizable.trashcan()
        case .toilets:
            return R.string.localizable.toilets()
        case .water:
            return R.string.localizable.water()
        case .laundromat:
            return R.string.localizable.laundry()
        case .blackWater:
            return R.string.localizable.blackwaterDisposal()
        case .usedWater:
            return R.string.localizable.wastewaterDisposal()
        case .bakery:
            return R.string.localizable.bakery()
        case .electricity:
            return R.string.localizable.powerSupply()

        case .poolEn:
            return R.string.localizable.pool()
        case .lpgEn:
            return R.string.localizable.liquefiedPetroleumGas()
        case .internet3GEn:
            return R.string.localizable.internet3G()
        case .wifiEn:
            return R.string.localizable.wiFi()
        case .showersEn:
            return R.string.localizable.showers()
        case .dogEn:
            return R.string.localizable.petWalking()
        case .washingMotorhomesEn:
            return R.string.localizable.camperCarWashing()
        case .trashCanEn:
            return R.string.localizable.trashcan()
        case .toiletsEn:
            return R.string.localizable.toilets()
        case .waterEn:
            return R.string.localizable.water()
        case .laundromatEn:
            return R.string.localizable.laundry()
        case .blackWaterEn:
            return R.string.localizable.blackwaterDisposal()
        case .usedWaterEn:
            return R.string.localizable.wastewaterDisposal()
        case .bakeryEn:
            return R.string.localizable.bakery()
        case .electricityEn:
            return R.string.localizable.powerSupply()

        case .unknown:
            return ""
        }
    }
}
