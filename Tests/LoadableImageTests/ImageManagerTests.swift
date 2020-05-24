//
//  ImageManagerTests.swift
//  LoadableImage
//
//  Created by CHIRKOV Andrey on 26.01.2020.
//

import XCTest
@testable import LoadableImage

class ImageManagerTests: XCTestCase {
    
    func test_Init_ShouldSetStateToLoading() {
        let imageURL = URL(string: "http://test.com/media/test_image.png")!
        let sut = ImageManager(loadable: imageURL)
        
        XCTAssertEqual(sut.state, .loading)
    }
    
    func test_Load_ShouldReturnImage() {
        let imageURL = URL(string: "http://test.com/media/test_image.png")!
        let sut = ImageManager(loadable: imageURL)
        
        sut.loadImage()
    }
}
