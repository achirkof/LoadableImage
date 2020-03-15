//
//  ImageManagerState.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 16.03.2020.
//

import UIKit

public enum ImageManagerState: Equatable {
    case loading
    case fetched(Result<UIImage, ImageManagerError>)

    public static func == (lhs: ImageManagerState, rhs: ImageManagerState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.fetched(let left), .fetched(let right)) where left == right:
            return true
        default:
            return false
        }
    }
}
