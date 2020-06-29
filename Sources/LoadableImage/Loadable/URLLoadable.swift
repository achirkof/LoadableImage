//
//  URLLoadable.swift
//
//  Created by CHIRKOV Andrey on 24.05.2020.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

import Combine

@available(iOS 13.0, macOS 10.15, *)
public class URLLoadable: PublisherProvider {
    private let url: URL?
    private let network: NetworkProvider

    public init(
        url: URL?,
        network: NetworkProvider = Network()
    ) {
        self.url = url
        self.network = network
    }

    public var publisher: AnyPublisher<UIImage, ImageLoadError> {
        guard let url = url else {
            return Fail<UIImage, ImageLoadError>(error: ImageLoadError.notExists)
                .eraseToAnyPublisher()
        }

        return network.publisher(for: url, cachePolicy: .reloadRevalidatingCacheData)
            .tryMap { (data, response) in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else {
                    throw ImageLoadError.loadError
                }

                guard let image = UIImage(data: data) else {
                    throw ImageLoadError.loadError
                }

                return image
            }
            .mapError { _ in
                return ImageLoadError.loadError
            }
            .eraseToAnyPublisher()
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension URLLoadable: Equatable {
    public static func == (lhs: URLLoadable, rhs: URLLoadable) -> Bool {
        return lhs.url == rhs.url
    }
}
