//
//  MockNetworkProvider.swift
//
//  Created by CHIRKOV Andrey on 06.06.2020.
//

import Combine
import LoadableImage
import UIKit

enum Mock {}

/// Mock Network provider
extension Mock {
    class MockNetworkProvider: NetworkProvider {
        var data: Data
        var response: HTTPURLResponse

        init(
            data: Data,
            response: HTTPURLResponse
        ) {
            self.data = data
            self.response = response
        }

        public func publisher(
            for url: URL,
            cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData
        ) -> AnyPublisher<Output, URLError> {
            return Just((data: data, response: response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
    }

    static func makeMockNetwork(with url: URL, data: Data, statusCode: Int) -> NetworkProvider {
        return MockNetworkProvider(
            data: data,
            response: HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )!
        )
    }
}

/// Mock Assets provider
extension Mock {
    class MockAssetsProvider: AssetsProvider {
        var image: UIImage?

        init(
            image: UIImage?
        ) {
            self.image = image
        }

        func publisher(for image: UIImage) -> AnyPublisher<Output, Never> {
            return Just(image)
                .setFailureType(to: Never.self)
                .eraseToAnyPublisher()
        }
    }

    static func makeMockAssets(with image: UIImage? = nil) -> AssetsProvider {
        return MockAssetsProvider(image: image)
    }
}
