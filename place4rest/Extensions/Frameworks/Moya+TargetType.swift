//
//  Moya+TargetType.swift
//  place4rest
//
//  Created by Igor Medelian on 2/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Moya

public extension TargetType {
    public var baseURL: URL {
        return Bundle.main.url(for: "BASE_URL")
    }

    public var sampleData: Data {
        return Data()
    }

    public var headers: [String: String]? {
        return nil
    }

    var validationType: ValidationType {
        return .successCodes
    }

}
