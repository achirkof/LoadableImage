//
//  UIImageLoadable.swift
//
//  Created by CHIRKOV Andrey on 30.05.2020.
//

import Combine
import UIKit

public final class UIImageLoadable: PublisherProvider {
    private let name: String
    private let assets: AssetsProvider

    public init(
        name: String,
        assets: AssetsProvider = Assets()
    ) {
        self.name = name
        self.assets = assets
    }

    public var publisher: AnyPublisher<UIImage, ImageLoadError> {
        return assets.publisher(for: name)
            .eraseToAnyPublisher()
    }
}

extension UIImageLoadable: Equatable {
    public static func == (lhs: UIImageLoadable, rhs: UIImageLoadable) -> Bool {
        return lhs.name == rhs.name
    }
}
