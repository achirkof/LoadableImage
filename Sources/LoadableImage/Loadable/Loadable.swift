//
//  Loadable.swift
//  
//
//  Created by CHIRKOV Andrey on 30.05.2020.
//

import Combine

public protocol Loadable {
    func load() -> AnyPublisher<UIImage, Error>
}
