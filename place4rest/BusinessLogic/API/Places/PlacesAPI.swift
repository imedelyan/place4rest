//
//  PlacesAPI.swift
//  place4rest
//
//  Created by Igor Medelian on 2/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Moya

enum PlacesAPI {
    case getAllPlaces
    case getPlaces(categories: [Category], for: [CategoryFor])
    case getPlace(id: Int)
}

extension PlacesAPI: TargetType {

    var path: String {
        switch self {
        case .getAllPlaces, .getPlaces:
            return "place"
        case .getPlace(let id):
            return "place/\(id)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getAllPlaces, .getPlace:
            return .requestPlain
        case let .getPlaces(categories, categoriesFor):
            var parameters: [String: String] = [:]
            if !categories.isEmpty {
                parameters["cat_place"] = categories.map({ String($0.rawValue) }).joined(separator: ",")
            }
            if !categoriesFor.isEmpty {
                parameters["cat_place_for"] = categoriesFor.map({ String($0.rawValue) }).joined(separator: ",")
            }
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }
}
