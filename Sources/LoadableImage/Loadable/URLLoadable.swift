//
//  URLLoadable.swift
//  
//
//  Created by CHIRKOV Andrey on 24.05.2020.
//

import Combine
import UIKit

extension URL: Loadable {
    public func load() -> AnyPublisher<UIImage, Error> {
        URLSession
            .shared
            .dataTaskPublisher(for: self)
            .tryMap { data, _ in
                guard let image = UIImage(data: data) else {
                    throw ImageManagerError.brokenData
                }

                return image
            }
            .eraseToAnyPublisher()
    }
}

extension UIImage: Loadable {
    public func load() -> AnyPublisher<UIImage, Error> {
        return Just(self)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
