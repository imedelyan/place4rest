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
    case getPlace(id: Int)
}

extension PlacesAPI: TargetType {

    var path: String {
        switch self {
        case .getAllPlaces:
            return "place"
        case .getPlace(let id):
            return "place/\(id)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }
}
