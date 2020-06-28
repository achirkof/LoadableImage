//
//  NetworkProvider.swift
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
public protocol NetworkProvider {
    typealias Output = URLSession.DataTaskPublisher.Output
    func publisher(for url: URL, cachePolicy: URLRequest.CachePolicy) -> AnyPublisher<Output, URLError>
}

@available(iOS 13.0, macOS 10.15, *)
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
