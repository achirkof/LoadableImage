//
//  Loadable.swift
//  
//  Created by CHIRKOV Andrey on 30.05.2020.
//

import Combine
import UIKit

public protocol Loadable {
    func load() -> AnyPublisher<UIImage, ImageLoadError>
    func equals(_ other: Loadable) -> Bool
}

extension Loadable where Self: Equatable {
    public func equals(_ other: Loadable) -> Bool {
        return other as? Self == self
    }
}

public extension Loadable {
    func eraseToAnyLoadable<T>() -> AnyImageLoadable<T> {
        return AnyImageLoadable<T>(self)
    }
}
