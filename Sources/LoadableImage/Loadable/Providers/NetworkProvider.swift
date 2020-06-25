//
//  NetworkProvider.swift
//
//  Created by CHIRKOV Andrey on 06.06.2020.
//

import Combine
import UIKit

public protocol NetworkProvider {
    typealias Output = URLSession.DataTaskPublisher.Output
    func publisher(for url: URL, cachePolicy: URLRequest.CachePolicy) -> AnyPublisher<Output, URLError>
}

public class Network: NetworkProvider {
    public init() {}

    public func publisher(
        for url: URL,
        cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData
    ) -> AnyPublisher<Output, URLError> {
        let request = URLRequest(url: url, cachePolicy: cachePolicy)
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .eraseToAnyPublisher()
    }
}
