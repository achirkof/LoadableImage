//
//  Image+Helpers.swift
//
//  Created by CHIRKOV Andrey on 02.06.2020.
//

import SwiftUI

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
    public typealias UIImage = NSImage
#endif

@available(iOS 12.0, macOS 10.10, *)
extension UIImage {
    func isEqualToImage(_ image: UIImage) -> Bool {
        #if os(iOS)
            return self.pngData() == image.pngData()
        #elseif os(OSX)
            return self.tiffRepresentation == image.tiffRepresentation
        #endif
    }

    public static func noImage() -> UIImage {
        #if os(iOS)
            return UIImage(named: "noImage", in: Bundle.module, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate)
        #elseif os(OSX)
            return Bundle.module.image(forResource: "noImage")!
        #endif
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension Image {
    init(
        image: UIImage
    ) {
        #if os(iOS)
            self.init(uiImage: image)
        #elseif os(OSX)
            self.init(nsImage: image)
        #endif
    }
}
