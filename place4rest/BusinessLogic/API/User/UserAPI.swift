//
//  AuthorizationAPI.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/5/19.
//  Copyright © 2019 imedelian. All rights reserved.
//


// http://place4rest.com/wp-json/jwt-auth/v1/token?username=imedelyan&password=de1q9NsG(MlvqKL(iwA2$hjh

import Moya

enum UserAPI {
    case login(email: String, password: String)
}

extension UserAPI: TargetType {
    
    var path: String {
        switch self {
        case .login:
            return "login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Task {
        let dateStr = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withInternetDateTime,
                                                                                                    .withFractionalSeconds])
        return .requestParameters(parameters: ["platform": "ios",
                                               "fire_base_token": "",
                                               "timezone": dateStr], encoding: URLEncoding.queryString)
    }
    
    var headers: [String: String]? {
        switch self {
        case .login(let email, let password):
            let namePass = Data("\(email):\(password)".utf8).base64EncodedString()
            return ["Authorization": "Basic \(namePass)"]
        }
    }
}
