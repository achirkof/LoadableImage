//
//  ImageCache.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 25.01.2020.
//

import Foundation

public class ImageCache {
    private var store: FileManager
    
    public typealias SaveResult = (Result<Media, CacheError>) -> Void

    public init(store: FileManager = .default) {
        self.store = store
    }

    public func save(media mediaData: Data, with name: String, completion: @escaping SaveResult) {
        guard let url = reference(for: name) else {
            completion(.failure(.failedReference))
            return
        }
        
        if store.createFile(atPath: url.path, contents: mediaData, attributes: nil) {
            completion(.success(.init(mediaData: mediaData, mediaName: name)))
        } else {
            completion(.failure(.failedToSave))
        }
    }
}

public struct Media {
    public var mediaData: Data
    public var mediaName: String
}

public enum CacheError: Error {
    case failedReference
    case failedToSave
}

extension ImageCache {
    func reference(for mediaName: String) -> URL? {
        guard let url = store.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(mediaName)
    }
}
