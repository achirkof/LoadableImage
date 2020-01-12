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
    @Published public var state: ImageLoadingState = .loading

    private let imageURL: String

    public init(imageURL: String) {
        self.imageURL = imageURL
    }

    public func load() {
        guard let url = URL(string: imageURL) else {
            print("Broken URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Unexpected response: \(response.statusCode)")
                DispatchQueue.main.async {
                    self.state = .fetched(.failure(.loadError))
                }
            }

            if let error = error {
                print("Error loading image: \(error)")
                DispatchQueue.main.async {
                    self.state = .fetched(.failure(.generic(error)))
                }
            }

            guard let imageData = data,
                let loadedImage = UIImage(data: imageData) else {
                print("No data received")
                DispatchQueue.main.async {
                    self.state = .fetched(.failure(.loadError))
                }
                return
            }

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                self.state = .fetched(.success(loadedImage))
            }

        }.resume()
    }
}

public enum ImageLoadingState {
    case loading
    case fetched(Result<UIImage, ImageManagerError>)
}

public enum ImageManagerError: Error {
    case generic(Error)
    case loadError
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
