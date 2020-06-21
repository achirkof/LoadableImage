//
//  UIImageLoadable.swift
//
//  Created by CHIRKOV Andrey on 30.05.2020.
//

import Combine
import UIKit

public final class UIImageLoadable: Loadable {
    private let name: String
    private let assets: AssetsProvider

    public init(
        name: String,
        assets: AssetsProvider = Assets()
    ) {
        self.name = name
        self.assets = assets
    }

    public func load() -> AnyPublisher<UIImage, ImageLoadError> {
        return assets.publisher(for: name)
            .eraseToAnyPublisher()
    }
}

extension UIImageLoadable: Equatable {
    public static func == (lhs: UIImageLoadable, rhs: UIImageLoadable) -> Bool {
        return lhs.name == rhs.name
    }
}

extension String: Loadable {
    public func load() -> AnyPublisher<UIImage, ImageLoadError> {
        let loadable = UIImageLoadable(name: self)
        return loadable.load()
    }
}
