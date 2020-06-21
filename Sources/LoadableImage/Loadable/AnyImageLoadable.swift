//
//  AnyImageLoadable.swift
//
//  Created by CHIRKOV Andrey on 21.06.2020.
//

import Combine
import UIKit

public struct AnyImageLoadable<DecodableLoadable: Decodable & Loadable>: Loadable, Equatable, Decodable {
    private let loadable: Loadable

    init(
        _ loadable: Loadable
    ) {
        self.loadable = loadable
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        loadable = try container.decode(DecodableLoadable.self)
    }

    public func load() -> AnyPublisher<UIImage, ImageLoadError> {
        return loadable.load()
    }

    public static func == (lhs: AnyImageLoadable, rhs: AnyImageLoadable) -> Bool {
        return lhs.loadable.equals(rhs.loadable)
    }
}
