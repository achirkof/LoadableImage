//
//  ImageManager.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//

import Combine
import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
/*
public class ImageManager: ObservableObject {
    @Published public var state: ImageManagerState = .loading

    private let imageURL: String
    private let cache: ImageCache?
    private var cancellable: AnyCancellable?

    public init(
        imageURL: String,
        cache: ImageCache? = .init()
    ) {
        self.imageURL = imageURL
        self.cache = cache
    }

    public func load() {
        guard let url = URL(string: imageURL) else {
            state = .fetched(.failure(.brokenUrl))
            return
        }

        let remoteImageDataPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }

        let cacheImageDataPublisher = loadFromCache(imageURL: imageURL)
            .map { $0 }

        cancellable = cacheImageDataPublisher
            .map { $0 }
            .catch { _ in
                remoteImageDataPublisher
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.state = .fetched(.failure(.generic(error)))
                }
            }, receiveValue: { data in
                guard let image = UIImage(data: data) else {
                    self.state = .fetched(.failure(.brokenData))
                    return
                }
                self.state = .fetched(.success(image))
                self.saveToCache(imageData: data, imageURL: self.imageURL)
            })
    }

    public func cancel() {
        cancellable?.cancel()
    }

    private func saveToCache(imageData: Data, imageURL: String) {
        cache?.save(media: imageData, with: imageURL) { _ in }
    }

    private func loadFromCache(imageURL: String) -> AnyPublisher<Data, Error> {
        return Future<Data, Error> { promise in
            self.cache?.load(media: imageURL) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let media):
                        promise(.success(media.mediaData))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
 */

public class ImageManager: ObservableObject {
    @Published public var state: ImageManagerState = .loading

    private let loadable: ImageLoadable
    private let cache: ImageCache?

    private var cancellable: AnyCancellable?

    init(
        loadable: ImageLoadable,
        cache: ImageCache? = .init()
    ) {
        self.loadable = loadable
        self.cache = cache
    }

    public func loadImage() {
        cancellable =
            loadable
            .load()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.state = .fetched(.failure(.generic(error)))
                    }
                },
                receiveValue: { [weak self] (image) in
                    self?.state = .fetched(.success(image))
                }
            )
    }

    public func cancel() {
        cancellable?.cancel()
    }

    private func saveToCache(imageData: Data, imageURL: String) {
        cache?.save(media: imageData, with: imageURL) { _ in }
    }
}
