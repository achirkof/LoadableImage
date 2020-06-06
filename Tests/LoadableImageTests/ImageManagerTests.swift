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
        let loadable = URLLoadable(url: URL(string: "https://any.url"))
        let sut = ImageManager(loadable: loadable)

        XCTAssertEqual(sut.state, .loading)
    }

    func test_init_whenLoadableIsNil_shouldSetStateFailed() {
        let sut = ImageManager(loadable: nil)

        sut.loadImage()

        XCTAssertEqual(sut.state, .failed(.notExists))
    }

    func test_init_whenURLIsNil_shouldSetStateLoadError() {
        let loadable = URLLoadable(url: nil)
        let sut = ImageManager(loadable: loadable)
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

    func test_loadImage_withBrokenURL_shouldSetStateToFailed() {
        let loadable = URLLoadable(url: URL(string: "https://broken.url"))
        let sut = ImageManager(loadable: loadable)
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

    func test_loadImage_withCorrectURL_shouldSetStateToFetched() {
        let mockNetwork = Mock.makeMockNetwork(
            with: URL(string: "https://any.url")!,
            data: Stub.image.pngData()!,
            statusCode: 200
        )
        let loadable = URLLoadable(url: URL(string: "https://any.url"), network: mockNetwork)
        let sut = ImageManager(loadable: loadable)
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
