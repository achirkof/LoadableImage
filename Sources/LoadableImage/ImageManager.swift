//
//  ImageManager.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//

import Combine
import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public class ImageManager: ObservableObject {
    @Published public var state: ImageManagerState = .loading
    
    private let imageURL: String
    private let cache: ImageCache?
    private var cancellable: AnyCancellable?
    
    public init(imageURL: String, cache: ImageCache? = .init()) {
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

public enum ImageManagerState: Equatable {
    case loading
    case fetched(Result<UIImage, ImageManagerError>)
    
    public static func == (lhs: ImageManagerState, rhs: ImageManagerState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.fetched(let left), .fetched(let right)) where left == right:
            return true
        default:
            return false
        }
    }
}

public enum ImageManagerError: Error, Equatable {
    case brokenUrl
    case brokenData
    case loadError
    case generic(Error)
    
    public static func == (lhs: ImageManagerError, rhs: ImageManagerError) -> Bool {
        return areEqual(lhs, rhs)
    }
}

extension ImageManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .loadError:
            return "ImageManager.loadError"
        default:
            return ""
        }
    }
}
