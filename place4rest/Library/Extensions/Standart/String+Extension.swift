//
//  String+Extension.swift
//  place4rest
//
//  Created by Igor Medelian on 3/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
