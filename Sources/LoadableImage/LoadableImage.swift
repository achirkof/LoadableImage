//
//  LoadableImage.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public struct LoadableImage: View {
    @ObservedObject var imageManager: ImageManager
    
    private let placeholder: UIImage?
    
    public init(imageURL: String, placeholder: UIImage? = nil) {
        self.imageManager = ImageManager(imageURL: imageURL)
        self.placeholder = placeholder
    }
    
    public var body: some View {
        ZStack {
            contentView
        }
        .onAppear(perform: loadMedia)
        .onDisappear(perform: cancelLoad)
    }
    
    private func loadMedia() {
        imageManager.load()
    }
    
    private func cancelLoad() {}
    
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
                        .aspectRatio(contentMode: .fit)
                )
                
            case .failure:
                return (placeholder != nil) ?
                    AnyView(ImagePlaceholder(placeholder: placeholder!)) :
                    AnyView(ImagePlaceholder())
            }
        }
    }
}
