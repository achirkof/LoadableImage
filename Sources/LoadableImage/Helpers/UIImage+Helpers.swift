//
//  File.swift
//
//  Created by CHIRKOV Andrey on 02.06.2020.
//

import UIKit

extension UIImage {
    func isEqualToImage(_ image: UIImage) -> Bool {
        return self.pngData() == image.pngData()
    }
}
