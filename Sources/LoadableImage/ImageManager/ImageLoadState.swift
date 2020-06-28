//
//  ImageLoadState.swift
//
//  Created by CHIRKOV Andrey on 16.03.2020.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

public enum ImageLoadState {
    case loading
    case fetched(UIImage)
    case failed(ImageLoadError)
}

@available(iOS 13.0, macOS 10.10, *)
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
