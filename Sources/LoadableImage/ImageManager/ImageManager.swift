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

    private let loadable: Loadable?

    private var cancellable: AnyCancellable?

    public init(
        loadable: Loadable?
    ) {
        self.loadable = loadable
    }

    public func loadImage() {
        guard let loadable = loadable
        else {
            state = .failed(.notExists)
            return
        }

        cancellable =
            loadable
            .load()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure:
                        self?.state = .failed(.loadError)
                    }
                },
                receiveValue: { [weak self] (image) in
                    self?.state = .fetched(image)
                }
            )
    }

    public func cancel() {
        cancellable?.cancel()
    }
}
