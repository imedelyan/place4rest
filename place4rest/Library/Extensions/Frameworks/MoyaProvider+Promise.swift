//
//  MoyaProvider+Promise.swift
//  place4rest
//
//  Created by Igor Medelian on 2/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Moya
import PromiseKit

extension MoyaProvider {
    func request(_ target: Target) -> Promise<Response> {
        return Promise<Moya.Response> { seal in
            self.request(target, callbackQueue: .main, progress: nil, completion: { result in
                switch result {
                case let .success(response):
                    seal.fulfill(response)
                case let .failure(error):
                    seal.reject(error)
                }
            })
        }
    }
}

extension Promise where T: Moya.Response {
    func decode<D: Decodable>(on queue: DispatchQueue = .global(qos: .utility), to type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder()) -> Promise<D> {
        return map (on: queue, { (response) in
            try response.map(D.self, atKeyPath: keyPath, using: decoder)
        })
    }
}
