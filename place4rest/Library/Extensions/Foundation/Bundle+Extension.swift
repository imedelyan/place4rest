//
//  Bundle+Extension.swift
//  place4rest
//
//  Created by Igor Medelian on 2/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Foundation

extension Bundle {
    public func url(for key: String) -> URL {
        guard let url = URL(string: string(for: key)) else {
            preconditionFailure("Can't make URL from KEY string")
        }
        return url
    }

    public func string(for key: String) -> String {
        guard let urlString = self.infoDictionary?[key] as? String else {
            preconditionFailure("KEY is not set in plist")
        }
        return urlString
    }
}
