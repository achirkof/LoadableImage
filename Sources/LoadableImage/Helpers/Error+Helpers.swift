//
//  Error+Helpers.swift
//
//  Created by CHIRKOV Andrey on 26.01.2020.
//

import Foundation

/**
 This is an equality on any 2 instance of Error.
 */

public func areEqual(_ lhs: Error, _ rhs: Error) -> Bool {
    return lhs.reflectedString == rhs.reflectedString
}

public extension Error {
    var reflectedString: String {
        // NOTE 1: We can just use the standard reflection for our case
        return String(reflecting: self)
    }

    // Same typed Equality
    func isEqual(to error: Self) -> Bool {
        return self.reflectedString == error.reflectedString
    }
}

public extension NSError {
    // prevents scenario where one would cast swift Error to NSError
    // whereby losing the associatedvalue in Obj-C realm.
    // (IntError.unknown as NSError("some")).(IntError.unknown as NSError)
    func isEqual(to error: NSError) -> Bool {
        let lhs = self as Error
        let rhs = error as Error
        return self.isEqual(error) && lhs.reflectedString == rhs.reflectedString
    }
}
