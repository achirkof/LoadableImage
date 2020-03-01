// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoadableImage",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LoadableImage",
            targets: ["LoadableImage"]),
    ],
    exclude: ["Example"],
    targets: [
        .target(
            name: "LoadableImage",
            dependencies: []),
        .testTarget(
            name: "LoadableImageTests",
            dependencies: ["LoadableImage"]),
    ]
)
