//
//  AssetsProvider.swift
//
//  Created by CHIRKOV Andrey on 06.06.2020.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

import Combine

@available(iOS 13.0, macOS 10.15, *)
public protocol AssetsProvider {
    typealias Output = Just<UIImage>.Output
    func publisher(for name: String) -> AnyPublisher<Output, ImageLoadError>
}

@available(iOS 13.0, macOS 10.15, *)
public class Assets: AssetsProvider {
    public init() {}

    public func publisher(for name: String) -> AnyPublisher<Output, ImageLoadError> {
        guard let image = UIImage(named: name) else {
            return Fail<UIImage, ImageLoadError>(error: .notExists)
                .eraseToAnyPublisher()
        }

        return Just(image)
            .setFailureType(to: ImageLoadError.self)
            .eraseToAnyPublisher()
    }
}
