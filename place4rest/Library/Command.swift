//
//  Command.swift
//  place4rest
//
//  Created by Igor Medelian on 2/20/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Foundation

final class Command {

    private let id: String
    private let action: () -> Void

    init(id: String = "unnamed", action: @escaping () -> Void) {
        self.id = id
        self.action = action
    }

    func perform() {
        action()
    }

    static let nop = Command { }
}

final class CommandWith<T> {

    let action: (T) -> Void

    init(action: @escaping (T) -> Void) {
        self.action = action
    }

    func perform(with value: T) {
        action(value)
    }

    func bind(to value: T) -> Command {
        return Command { self.perform(with: value) }
    }

    static var nop: CommandWith {
        return CommandWith { _ in }
    }

    func dispatched(on queue: DispatchQueue) -> CommandWith {
        return CommandWith { value in
            queue.async {
                self.perform(with: value)
            }
        }
    }

    func then(_ another: CommandWith) -> CommandWith {
        return CommandWith { value in
            self.perform(with: value)
            another.perform(with: value)
        }
    }
}

extension CommandWith: Hashable {
    static func ==(lhs: CommandWith<T>, rhs: CommandWith<T>) -> Bool { // swiftlint:disable:this operator_whitespace
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

    var hashValue: Int { // swiftlint:disable:this legacy_hashing
        return ObjectIdentifier(self).hashValue
    }
}
