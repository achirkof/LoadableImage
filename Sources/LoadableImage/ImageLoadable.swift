//
//  ImageLoadable.swift
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//

import SwiftUI


/// Wrapper for the SwiftUI `Image` with loading indicator, caching and placeholder
///
/// Can be initialized with:
/// - UIImage `ImageLoadable(image:)`:
///
///     ImageLoadable(
///         image: UIImage(named: "robot"),
///         contentMode: .fit
///     )
///
/// - URL `ImageLoadable(url:)`:
///
///     ImageLoadable(
///         url: URL(url: "https://robots.com/robot.png"),
///         contentMode: .fit
///     )
///
/// Optional parameters:
/// - `optional` ContentMode(fit/fill). Default `fit`
/// - `optional` TemplateRenderingMode(template/original). Default `original`
/// - `optional` UIImage placeholder. Default placeholder provided
@available(iOS 13.0, macOS 10.15, *)
public struct ImageLoadable: View {
    @ObservedObject var imageManager: ImageManager

    private let contentMode: ContentMode
    private let renderingMode: Image.TemplateRenderingMode
    private let placeholder: UIImage?

    /// Initialization with UIImage
    /// - Parameters:
    ///   - image: Image to put
    ///   - contentMode: image `ContentMode` (fit/fill)
    ///   - renderingMode: image `TemplateRenderingMode` (template/original)
    ///   - placeholder: `optional` image placeholder to put in case of image with provided name not exists
    public init(
        image: UIImage?,
        contentMode: ContentMode = .fit,
        renderingMode: Image.TemplateRenderingMode = .original,
        placeholder: UIImage? = nil
    ) {
        self.imageManager = ImageManager(loadable: UIImageLoadable(image: image))
        self.contentMode = contentMode
        self.renderingMode = renderingMode
        self.placeholder = placeholder
    }

    /// Initialization with URL
    /// - Parameters:
    ///   - url: URL for the image
    ///   - contentMode: image `ContentMode` (fit/fill)
    ///   - renderingMode: image `TemplateRenderingMode` (template/original)
    ///   - placeholder: `optional` image placeholder to put in case of download error
    public init(
        url: URL?,
        contentMode: ContentMode = .fit,
        renderingMode: Image.TemplateRenderingMode = .original,
        placeholder: UIImage? = nil
    ) {
        self.imageManager = ImageManager(loadable: URLLoadable(url: url))
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

        case let .fetched(image):
            return AnyView(
                Image(uiImage: image)
                    .resizable()
                    .renderingMode(renderingMode)
                    .aspectRatio(contentMode: contentMode)
            )

        case .failed:
            return placeholderView
        }
    }

    private var placeholderView: AnyView {
        return (placeholder != nil)
            ? AnyView(ImagePlaceholder(placeholder: placeholder!)) : AnyView(ImagePlaceholder())
    }
}
