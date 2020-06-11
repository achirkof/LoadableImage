//
//  UIImageLoadable.swift
//
//  Created by CHIRKOV Andrey on 30.05.2020.
//

import Combine
import UIKit

public class UIImageLoadable: Loadable {
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
