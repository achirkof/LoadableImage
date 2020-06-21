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

public extension Loadable where Self: Equatable {
    func equals(_ other: Loadable) -> Bool {
        return other as? Self == self
    }
}
