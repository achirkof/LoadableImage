//
//  URLLoadableTests.swift
//
//  Created by CHIRKOV Andrey on 31.05.2020.
//

import Combine
import LoadableImage
import XCTest

class URLLoadableTests: XCTestCase {
    func test_load_whenURLIsNil_shouldReturnImage() {
        let sut = URLLoadable(url: nil)
        let expectation = XCTestExpectation(description: "Downloading from Nil URL")

        let loadImagePublisher = sut.publisher
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        XCTFail("Should receive error, but receive completion")

                    case let .failure(error):
                        print("Received error: \(error)")
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in
                    XCTFail("Should not have received an image with the failed URL")
                }
            )

        XCTAssertNotNil(loadImagePublisher)
        wait(for: [expectation], timeout: 5.0)
    }

    func test_load_withCorrectURL_shouldReturnImage() {
        let url = URL(string: "https://robohash.org/loadablerobot")
        let data = Stub.image.data
        let mockNetwork = Mock.makeMockNetwork(with: url!, data: data!, statusCode: 200)
        let sut = URLLoadable(url: url, network: mockNetwork)
        let expectation = XCTestExpectation(description: "Downloading from " + "\(url?.absoluteString ?? "URL")")

        let loadImagePublisher = sut.publisher
            .sink(
                receiveCompletion: { completion in
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

        XCTAssertNotNil(loadImagePublisher)
        wait(for: [expectation], timeout: 5.0)
    }

    func test_load_withIncorrectURL_shouldReturnError() {
        let url = URL(string: "https://broken.url")
        let sut = URLLoadable(url: url)
        let expectation = XCTestExpectation(description: "Downloading from " + "\(url?.absoluteString ?? "URL")")

        let loadImagePublisher = sut.publisher
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        XCTFail("Should receive error, but receive completion")

                    case let .failure(error):
                        print("Received error: \(error)")
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in
                    XCTFail("Should not have received an image with the failed URL")
                }
            )

        XCTAssertNotNil(loadImagePublisher)
        wait(for: [expectation], timeout: 5.0)
    }

    func test_load_withBadResponse_shouldReturnError() {
        let url = URL(string: "https://robohash.org/loadablerobot")
        let data = "any data".data(using: .utf8)
        let mockNetwork = Mock.makeMockNetwork(with: url!, data: data!, statusCode: 404)
        let sut = URLLoadable(url: url, network: mockNetwork)
        let expectation = XCTestExpectation(description: "Downloading from " + "\(url?.absoluteString ?? "URL")")

        let loadImagePublisher = sut.publisher
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        XCTFail("Should receive error, but receive completion")

                    case let .failure(error):
                        print("Received error: \(error)")
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in
                    XCTFail("Should not have received an image with the failed URL")
                }
            )

        XCTAssertNotNil(loadImagePublisher)
        wait(for: [expectation], timeout: 5.0)
    }

    func test_load_withBrokenData_shouldReturnError() {
        let url = URL(string: "https://robohash.org/loadablerobot")
        let data = "not an image".data(using: .utf8)
        let mockNetwork = Mock.makeMockNetwork(with: url!, data: data!, statusCode: 200)
        let sut = URLLoadable(url: url, network: mockNetwork)
        let expectation = XCTestExpectation(description: "Downloading from " + "\(url?.absoluteString ?? "URL")")

        let loadImagePublisher = sut.publisher
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        XCTFail("Should receive error, but receive completion")

                    case let .failure(error):
                        print("Received error: \(error)")
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in
                    XCTFail("Should not have received an image with the failed URL")
                }
            )

        XCTAssertNotNil(loadImagePublisher)
        wait(for: [expectation], timeout: 5.0)
    }

    func test_equatable_equalShouldReturnTrue() {
        let loadable1 = URL(string: "https://robohash.org/loadablerobot")
        let loadable2 = URL(string: "https://robohash.org/loadablerobot")

        XCTAssertEqual(loadable1, loadable2)
    }

    func test_equatable_differentShouldReturnFalse() {
        let loadable1 = URL(string: "https://robohash.org/loadablerobot1")
        let loadable2 = URL(string: "https://robohash.org/loadablerobot2")

        XCTAssertNotEqual(loadable1, loadable2)
    }
}
