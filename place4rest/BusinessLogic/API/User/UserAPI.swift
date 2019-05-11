//
//  AuthorizationAPI.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/5/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Moya

enum UserAPI {
    case getToken(username: String, password: String)
    case login(username: String, password: String)
    case getUser(token: String)
    case update(username: String, name: String, email: String, token: String)
    case updatePassword(newPassword: String, oldPassword: String, token: String)
    case logout(token: String)
}

extension UserAPI: TargetType {

    var path: String {
        switch self {
        case .getToken:
            return "jwt-auth/v1/token"
        case .login:
            return ""
        case .getUser:
            return ""
        case .update:
        return ""
        case .updatePassword:
            return ""
        case .logout:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getToken, .login, .update, .updatePassword, .logout:
            return .post
        case .getUser:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .getToken(username, password):
            return .requestParameters(parameters: ["username": username,
                                                   "password": password], encoding: URLEncoding.queryString)
        case .login:
            return .requestPlain
        case .getUser:
            return .requestPlain
        case .update:
            return .requestPlain
        case .updatePassword:
            return .requestPlain
        case .logout:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getToken, .login:
            return nil
        case .getUser(let token), .update(_, _, _, let token), .updatePassword(_, _, let token), .logout(let token):
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
