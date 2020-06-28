//
//  UIImageLoadableTests.swift
//
//  Created by CHIRKOV Andrey on 06.06.2020.
//

import LoadableImage
import XCTest

class UIImageLoadableTests: XCTestCase {
    func test_load_withImageInAssets_shouldReturnImage() {
        let assetsMock = Mock.makeMockAssets(with: Stub.image)
        let sut = UIImageLoadable(name: "", assets: assetsMock)
        let expectation = XCTestExpectation(description: "Loading image from assets catalog")

        let loadImagePublisher = sut.publisher
            .sink(
                receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print(".sink() received the completion:", String(describing: completion))
                        expectation.fulfill()

                    case let .failure(error):
                        XCTFail("Should receive image, but receive error: \(error)")
                    }
                },
                receiveValue: { image in
                    XCTAssertNotNil(image)
                }
            )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(loadImagePublisher)
    }

    func test_load_withNoImageInAssets_shouldReturnError() {
        let assetsMock = Mock.makeMockAssets(with: nil)
        let sut = UIImageLoadable(name: "", assets: assetsMock)
        let expectation = XCTestExpectation(description: "Loading image from assets catalog")

        let loadImagePublisher = sut.publisher
            .sink(
                receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        XCTFail("Should receive error, but receive completion")

                    case let .failure(error):
                        print("Received error: \(error)")
                        expectation.fulfill()
                    }
                },
                receiveValue: { image in
                    XCTFail("Should not load an image if it's not in Assets catalog")
                }
            )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(loadImagePublisher)
    }

    func test_equatable_equalShouldReturnTrue() {
        let loadable1 = UIImageLoadable(name: "image")
        let loadable2 = UIImageLoadable(name: "image")

        XCTAssertEqual(loadable1, loadable2)
    }

    func test_equatable_differentShouldReturnFalse() {
        let loadable1 = UIImageLoadable(name: "imageOne")
        let loadable2 = UIImageLoadable(name: "imageTwo")

        XCTAssertNotEqual(loadable1, loadable2)
    }
}
