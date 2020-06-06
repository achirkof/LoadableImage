//
//  AssetsProvider.swift
//
//  Created by CHIRKOV Andrey on 06.06.2020.
//

import Combine
import UIKit

public protocol AssetsProvider {
    typealias Output = Just<UIImage>.Output
    func publisher(for image: UIImage) -> AnyPublisher<Output, Never>
}

public class Assets: AssetsProvider {
    public init() {}

    public func publisher(for image: UIImage) -> AnyPublisher<Output, Never> {
        return Just(image)
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
    }
}
