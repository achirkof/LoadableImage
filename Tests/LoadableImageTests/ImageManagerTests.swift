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
        let expectation = XCTestExpectation(description: "async sink test")

        let cancellable = sut.objectWillChange
        .sink { _ in
            expectation.fulfill()
        }

        sut.loadImage()

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(cancellable)
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
        let mockNetwork = makeMockNetwork(
            with: URL(string: "https://any.url")!,
            data: imageStub.pngData()!,
            statusCode: 200
        )
        let loadable = URLLoadable(url: URL(string: "https://any.url"), network: mockNetwork)
        let sut = ImageManager(loadable: loadable)
        let expectation = XCTestExpectation(description: "async sink test")

        let cancellable = sut.objectWillChange
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        XCTFail("Shouldn't receive '.finished' signal")
                        break

                    case let .failure(error):
                        XCTFail("Shouldn't receive '.failure' signal, but get a error: \(error)")
                        break
                    }
                },
                receiveValue: { value in
                    XCTAssertNotNil(value)
                    expectation.fulfill()
                }
            )

        sut.loadImage()
        wait(for: [expectation], timeout: 5.0)

        XCTAssertNotNil(cancellable)
        XCTAssertEqual(sut.state, .fetched(imageStub))
    }
}


extension ImageManagerTests {
    // MARK: - Helpers
    private func makeMockNetwork(with url: URL, data: Data, statusCode: Int) -> NetworkProvider {
        return MockNetworkProvider(
            data: data,
            response: HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )!
        )
    }

    private var imageStub: UIImage {
        UIImage.make(withColor: .red)
    }
}

private class MockNetworkProvider: NetworkProvider {
    var data: Data
    var response: HTTPURLResponse

    init(
        data: Data,
        response: HTTPURLResponse
    ) {
        self.data = data
        self.response = response
    }

    public func publisher(
        for url: URL,
        cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData
    ) -> AnyPublisher<Output, URLError> {
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
