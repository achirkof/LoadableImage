//
//  ImageCacheTests.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 25.01.2020.
//

import XCTest
import LoadableImage

class ImageCacheTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ImageCache_WhenSave_ShouldStoreImage() {
        let sut = ImageCache()
        let imageData = UIImage.make(withColor: .red).pngData()!
        let imageName = "test_image.png"
        var savedMedia: Media?
        
        let promise = expectation(description: "Wait for save media")
        sut.save(media: imageData, with: imageName) { (result) in
            savedMedia = try? result.get()
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1.0)
        
        XCTAssertEqual(savedMedia?.mediaData, imageData)
        XCTAssertEqual(savedMedia?.mediaName, imageName)
    }
}

private extension UIImage {
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
}
