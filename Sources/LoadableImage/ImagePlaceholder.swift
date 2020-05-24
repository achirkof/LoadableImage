//
//  ImagePlaceholder.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//

import SwiftUI

@available(iOS 13.0.0, macOS 10.15, *)
public struct ImagePlaceholder: View {
    private var placeholder: UIImage

    public init(
        placeholder: UIImage = UIImage.noImage()) {
        self.placeholder = placeholder
    }

    public var body: some View {
        Image(uiImage: placeholder)
    }
}

extension UIImage {
    public static func noImage() -> UIImage {
         return UIImage(named: "noImage")!.withRenderingMode(.alwaysTemplate)
    }
}
