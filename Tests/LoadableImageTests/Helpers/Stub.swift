//
//  Stub.swift
//
//  Created by CHIRKOV Andrey on 06.06.2020.
//

import UIKit

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

    static var robotWithURLImage: String {
        return
            """
                {
                    "name": "Robot-1",
                    "image": "https://robohash.org/loadablerobot"
                }
            """
    }

    static var robotWithAssetsImage: String {
        return
            """
                {
                    "name": "Robot-1",
                    "image": "robot4H1"
                }
            """
    }
}
