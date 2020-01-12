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
    private var size: CGSize
    
    public init(
        placeholder: UIImage = UIImage.noImage(),
        size: CGSize = CGSize(width: 30, height: 30)) {
        self.placeholder = placeholder
        self.size = size
    }
    
    public var body: some View {
        Image(uiImage: placeholder)
            .resizable()
            .frame(width: size.width, height: size.height, alignment: .center)
            .aspectRatio(contentMode: .fit)
    }
}

extension UIImage {
    public static func noImage() -> UIImage {
        return UIImage(named: "noImage")!.withRenderingMode(.alwaysTemplate)
    }
}
