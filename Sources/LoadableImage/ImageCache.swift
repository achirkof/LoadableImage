//
//  ImageCache.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 25.01.2020.
//

import Foundation

public class ImageCache {
    private var store: FileManager
    
    public typealias CacheResult = (Result<Media, CacheError>) -> Void

    public init(store: FileManager = .default) {
        self.store = store
    }

    public func save(media mediaData: Data, with name: String, completion: @escaping CacheResult) {
        guard let url = reference(for: name) else {
            completion(.failure(.invalidReference))
            return
        }
        
        if store.createFile(atPath: url.path, contents: mediaData, attributes: nil) {
            completion(.success(.init(mediaData: mediaData, mediaName: name)))
        } else {
            completion(.failure(.failedToSave))
        }
    }
    
    public func load(media mediaURL: String, completion: @escaping CacheResult) {
        guard let mediaName = URL(string: mediaURL)?.lastPathComponent,
            let url = reference(for: mediaName) else {
                completion(.failure(.invalidReference))
            return
        }

        guard let mediaData = store.contents(atPath: url.path) else {
            completion(.failure(.failedToRetreive))
            return
        }

        completion(.success(.init(mediaData: mediaData, mediaName: mediaName)))
    }
}

public struct Media {
    public var mediaData: Data
    public var mediaName: String
}

public enum CacheError: Error {
    case invalidReference
    case failedToSave
    case failedToRetreive
}

extension ImageCache {
    func reference(for mediaName: String) -> URL? {
        guard let url = store.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(mediaName)
    }
}
