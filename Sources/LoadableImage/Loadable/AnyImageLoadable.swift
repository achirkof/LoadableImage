//
//  AnyImageLoadable.swift
//
//  Created by CHIRKOV Andrey on 21.06.2020.
//

import Combine
import UIKit

struct AnyImageLoadable: Loadable, Equatable {
    private let loadable: Loadable

    init(
        _ loadable: Loadable
    ) {
        self.loadable = loadable
    }

    func load() -> AnyPublisher<UIImage, ImageLoadError> {
        return loadable.load()
    }

    static func == (lhs: AnyImageLoadable, rhs: AnyImageLoadable) -> Bool {
        return lhs.loadable.equals(rhs.loadable)
    }
}
