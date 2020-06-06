//
//  ImageLoadState.swift
//
//  Created by CHIRKOV Andrey on 16.03.2020.
//

import UIKit

public enum ImageLoadState {
    case loading
    case fetched(UIImage)
    case failed(ImageLoadError)
}

extension ImageLoadState: Equatable {
    public static func == (lhs: ImageLoadState, rhs: ImageLoadState) -> Bool {
        switch (lhs, rhs) {
        case (let .fetched(left), let .fetched(right)):
            return left.isEqualToImage(right)

        case (let .failed(left), let .failed(right)):
            return left == right

        case (.loading, .loading):
            return true

        default:
            return false
        }
    }
}
