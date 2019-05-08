//
//  Array+Extension.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/5/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func index(of element: Element) -> Int? {
        for i in 0...self.count - 1 where element == self[i] {
            return i
        }
        return nil
    }
}
