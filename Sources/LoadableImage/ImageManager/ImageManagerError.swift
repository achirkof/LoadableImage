//
//  ImageManagerError.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 16.03.2020.
//

import Foundation

public enum ImageManagerError: Error, Equatable {
    case brokenUrl
    case brokenData
    case loadError
    case generic(Error)

    public static func == (lhs: ImageManagerError, rhs: ImageManagerError) -> Bool {
        return areEqual(lhs, rhs)
    }
}

extension ImageManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .loadError:
            return "ImageManager.loadError"
        default:
            return ""
        }
    }
}

