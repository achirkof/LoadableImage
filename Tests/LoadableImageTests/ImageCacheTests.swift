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
    
    func test_ImageCache_WhenSave_ShouldStoreImageData() {
        let sut = ImageCache()
        let imageData = UIImage.make(withColor: .red).pngData()!
        let imageName = "test_image.png"
        let mediaURL = "http://test.com/media/\(imageName)"
        var savedMedia: Media?
        
        let promise = expectation(description: "Wait for save media")
        sut.save(media: imageData, with: mediaURL) { (result) in
            savedMedia = try? result.get()
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1.0)
        
        XCTAssertEqual(savedMedia?.mediaData, imageData)
        XCTAssertEqual(savedMedia?.mediaName, imageName)
    }
    
    func test_ImageCache_WhenLoad_ShouldReturnImageData() {
        let sut = ImageCache()
        let imageData = UIImage.make(withColor: .red).pngData()!
        let imageName = "test_image.png"
        let mediaURL = "http://test.com/media/\(imageName)"
        var receivedMedia: Media?
        
        sut.save(media: imageData, with: mediaURL) { _ in }
        
        let promise = expectation(description: "Wait for receive media")
        sut.load(media: mediaURL) { (result) in
            receivedMedia = try? result.get()
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1.0)
        
        XCTAssertEqual(receivedMedia?.mediaData, imageData)
        XCTAssertEqual(receivedMedia?.mediaName, imageName)
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
