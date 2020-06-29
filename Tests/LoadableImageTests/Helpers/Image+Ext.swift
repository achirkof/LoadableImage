//
//  Image+Ext.swift
//
//  Created by CHIRKOV Andrey on 02.06.2020.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
    typealias UIImage = NSImage
#endif

#if os(iOS)
    extension UIImage {
        static func make(withColor color: UIColor) -> UIImage {
            let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(color.cgColor)
            context.fill(rect)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return img!
        }

        var data: Data? {
            return self.pngData()
        }
    }
#elseif os(OSX)
    extension UIImage {
        static func make(withColor color: NSColor) -> UIImage {
            let size = NSSize(width: 1, height: 1)
            let image = UIImage(size: size)
            image.lockFocus()
            color.drawSwatch(in: NSRect(x: 0, y: 0, width: size.width, height: size.height))
            image.unlockFocus()
            return image
        }

        var data: Data? {
            return tiffRepresentation
        }
    }
#endif
