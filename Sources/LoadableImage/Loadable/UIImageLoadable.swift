//
//  UIImageLoadable.swift
//
//  Created by CHIRKOV Andrey on 30.05.2020.
//

import Combine
import UIKit

public final class UIImageLoadable: Loadable {
    private let image: UIImage?
    private let assets: AssetsProvider

    public init(
        image: UIImage?,
        assets: AssetsProvider = Assets()
    ) {
        self.image = image
        self.assets = assets
    }

    public func load() -> AnyPublisher<UIImage, ImageLoadError> {
        guard let image = image else {
            return Fail<UIImage, ImageLoadError>(error: .notExists)
                .eraseToAnyPublisher()
        }

        return assets.publisher(for: image)
            .setFailureType(to: ImageLoadError.self)
            .eraseToAnyPublisher()
    }
}

extension UIImageLoadable: Equatable {
    public static func == (lhs: UIImageLoadable, rhs: UIImageLoadable) -> Bool {
        return lhs.image?.pngData() == rhs.image?.pngData()
    }
}

extension UIImage: Loadable {
    public func load() -> AnyPublisher<UIImage, ImageLoadError> {
        let loadable = UIImageLoadable(image: self)
        return loadable.load()
    }
}
