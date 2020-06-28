//
//  File.swift
//  
//  Created by CHIRKOV Andrey on 28.06.2020.
//

import Combine
import SwiftUI

protocol PublisherProvider {
    var publisher: AnyPublisher<UIImage, ImageLoadError> { get }
}
