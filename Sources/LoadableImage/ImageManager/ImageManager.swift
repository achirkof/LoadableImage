//
//  ImageManager.swift
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//

import Combine
import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public class ImageManager: ObservableObject {
    @Published public var state: ImageLoadState = .loading

    private let source: String

    private var cancellable: AnyCancellable?

    public init(
        source: String
    ) {
        self.source = source
    }

    public func loadImage() {
        state = .failed(.notExists)

        let networkImagePublisher = URLLoadable(url: URL(string: source))
        let localImagePublisher = UIImageLoadable(name: source)

        localImagePublisher
            .publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (completion) in
                switch completion {
                    case .finished:
                        break
                    case .failure:
                        self?.state = .failed(.loadError)
                }
            } receiveValue: { [weak self] (image) in
                self?.state = .fetched(image)
            }
    }

//    public func loadImage() {
//        guard let loadable = loadable
//        else {
//            state = .failed(.notExists)
//            return
//        }
//
//        cancellable =
//            loadable
//            .load()
//            .receive(on: DispatchQueue.main)
//            .sink(
//                receiveCompletion: { [weak self] (completion) in
//                    switch completion {
//                    case .finished:
//                        break
//                    case .failure:
//                        self?.state = .failed(.loadError)
//                    }
//                },
//                receiveValue: { [weak self] (image) in
//                    self?.state = .fetched(image)
//                }
//            )
//    }

    public func cancel() {
        cancellable?.cancel()
    }
}
