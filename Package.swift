// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoadableImage",
    products: [
        .library(
            name: "LoadableImage",
            targets: ["LoadableImage"]),
    ],
    targets: [
        .target(
            name: "LoadableImage",
            dependencies: []),
        .testTarget(
            name: "LoadableImageTests",
            dependencies: ["LoadableImage"]),
    ],
    exclude: ["Example"]
)
