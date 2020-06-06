//
//  ImageLoadError.swift
//
//  Created by CHIRKOV Andrey on 16.03.2020.
//

import Foundation

public enum ImageLoadError: Error, Equatable {
    case notExists
    case loadError

    public static func == (lhs: ImageLoadError, rhs: ImageLoadError) -> Bool {
        return areEqual(lhs, rhs)
    }
}

extension ImageLoadError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .loadError:
            return "ImageManager.loadError"
        default:
            return ""
        }
    }
}

