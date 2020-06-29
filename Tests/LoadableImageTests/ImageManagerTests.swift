//
//  ImageManagerTests.swift
//
//  Created by CHIRKOV Andrey on 26.01.2020.
//

import Combine
import LoadableImage
import XCTest

class ImageManagerTests: XCTestCase {
    func test_init_shouldSetStateToLoading() {
        let local = UIImageLoadable(name: "any_name").publisher
        let network = URLLoadable(url: URL(string: "https://any.url")).publisher
        let sut = ImageManager(localImagePublisher: local, networkImagePublisher: network)

        XCTAssertEqual(sut.state, .loading)
    }

    func test_init_whenURLIsNilAndLocalImageNotExists_shouldSetStateToFailed() {
        let local = UIImageLoadable(name: "image_not_exists").publisher
        let network = URLLoadable(url: nil).publisher
        let sut = ImageManager(localImagePublisher: local, networkImagePublisher: network)
        let expectation = XCTestExpectation(description: "async sink test")

        let cancellable = sut.objectWillChange
            .sink { _ in
                expectation.fulfill()
            }

        sut.loadImage()

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(cancellable)
        XCTAssertEqual(sut.state, .failed(.loadError))
    }

    func test_init_whenURLIsNilButLocalImageExists_shouldSetStateToFetched() {
        let mockAssets = Mock.makeMockAssets(with: Stub.image)
        let local = UIImageLoadable(name: "existed_image", assets: mockAssets).publisher
        let network = URLLoadable(url: nil).publisher
        let sut = ImageManager(localImagePublisher: local, networkImagePublisher: network)
        let expectation = XCTestExpectation(description: "async sink test")

        let cancellable = sut.objectWillChange
            .sink { _ in
                expectation.fulfill()
            }

        sut.loadImage()

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(cancellable)
        XCTAssertEqual(sut.state, .fetched(Stub.image))
    }

    func test_init_whenLocalImageNotExistsButURLIsCorrect_shouldSetStateToFetched() {
        let local = UIImageLoadable(name: "image_not_exists").publisher
        let mockNetwork = Mock.makeMockNetwork(
            with: URL(string: "https://existed-image.url")!,
            data: Stub.image.data!,
            statusCode: 200
        )
        let network = URLLoadable(url: URL(string: "https://existed-image.url"), network: mockNetwork).publisher
        let sut = ImageManager(localImagePublisher: local, networkImagePublisher: network)
        let expectation = XCTestExpectation(description: "async sink test")

        let cancellable = sut.objectWillChange
            .sink { _ in
                expectation.fulfill()
            }

        sut.loadImage()

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(cancellable)
        XCTAssertEqual(sut.state, .fetched(Stub.image))
    }
}
