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

    private let networkImagePublisher: AnyPublisher<UIImage, ImageLoadError>
    private let localImagePublisher: AnyPublisher<UIImage, ImageLoadError>

    private var cancellables = Set<AnyCancellable>()

    public init(
        localImagePublisher: AnyPublisher<UIImage, ImageLoadError>,
        networkImagePublisher: AnyPublisher<UIImage, ImageLoadError>
    ) {
        self.localImagePublisher = localImagePublisher
        self.networkImagePublisher = networkImagePublisher
    }

    public func loadImage() {
        localImagePublisher
            .catch { _ in
                self.networkImagePublisher
            }
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
            }.store(in: &cancellables)

    }

    public func cancel() {
        _ = cancellables
            .compactMap { $0.cancel() }
    }
}
