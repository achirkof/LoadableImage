//
//  Stub.swift
//
//  Created by CHIRKOV Andrey on 06.06.2020.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

enum Stub {
    static var image: UIImage {
        UIImage.make(withColor: .black)
    }

    static var imageRed: UIImage {
        UIImage.make(withColor: .red)
    }

    static var imageYellow: UIImage {
        UIImage.make(withColor: .yellow)
    }
}
