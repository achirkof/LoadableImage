//
//  PublisherProvider.swift
//  
//  Created by CHIRKOV Andrey on 28.06.2020.
//

import Combine
import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
protocol PublisherProvider {
    var publisher: AnyPublisher<UIImage, ImageLoadError> { get }
}
