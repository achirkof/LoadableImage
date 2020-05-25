//
//  Loadable.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public struct ImageLoadable: View {
    @ObservedObject var imageManager: ImageManager

    private let contentMode: ContentMode
    private let renderingMode: Image.TemplateRenderingMode
    private let placeholder: UIImage?

    public init(
        image: UIImage?,
        contentMode: ContentMode = .fit,
        renderingMode: Image.TemplateRenderingMode = .original,
        placeholder: UIImage? = nil
    ) {
        self.imageManager = ImageManager(loadable: image)
        self.contentMode = contentMode
        self.renderingMode = renderingMode
        self.placeholder = placeholder
    }

    public init(
        url: URL?,
        contentMode: ContentMode = .fit,
        renderingMode: Image.TemplateRenderingMode = .original,
        placeholder: UIImage? = nil
    ) {
        self.imageManager = ImageManager(loadable: url)
        self.contentMode = contentMode
        self.renderingMode = renderingMode
        self.placeholder = placeholder
    }

    public var body: some View {
        ZStack {
            contentView
        }
        .onAppear(perform: loadImage)
        .onDisappear(perform: cancelLoad)
    }

    private func loadImage() {
        imageManager.loadImage()
    }

    private func cancelLoad() {
        imageManager.cancel()
    }

    private var contentView: AnyView {
        switch imageManager.state {
        case .loading:
            return AnyView(
                ActivityIndicator(isAnimating: true)
            )

        case let .fetched(result):
            switch result {
            case let .success(image):
                return AnyView(
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(renderingMode)
                        .aspectRatio(contentMode: contentMode)
                )

            case .failure:
                return placeholderView
            }

        case .failToLoad:
            return placeholderView
        }
    }

    private var placeholderView: AnyView {
        return (placeholder != nil)
            ? AnyView(ImagePlaceholder(placeholder: placeholder!)) : AnyView(ImagePlaceholder())
    }
}
