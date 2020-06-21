//
//  URLLoadable.swift
//
//  Created by CHIRKOV Andrey on 24.05.2020.
//

import Combine
import UIKit

public class URLLoadable: Loadable {
    private let url: URL?
    private let network: NetworkProvider

    public init(
        url: URL?,
        network: NetworkProvider = Network()
    ) {
        self.url = url
        self.network = network
    }

    public func load() -> AnyPublisher<UIImage, ImageLoadError> {
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
            .mapError { error -> ImageLoadError in
                return ImageLoadError.loadError
            }
            .eraseToAnyPublisher()
    }
}

extension URLLoadable: Equatable {
    public static func == (lhs: URLLoadable, rhs: URLLoadable) -> Bool {
        return lhs.url == rhs.url
    }
}

extension URLLoadable {
    func any() -> AnyImageLoadable {
        return AnyImageLoadable(self)
    }
}
