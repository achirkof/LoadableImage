// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "LoadableImage",
    platforms: [
        SupportedPlatform.iOS(SupportedPlatform.IOSVersion.v13)
    ],
    products: [
        .library(name: "LoadableImage", targets: ["LoadableImage"])
    ],
    dependencies: [],
    targets: [
        .target(name: "LoadableImage", dependencies: []),
        .testTarget(name: "LoadableImageTests", dependencies: ["LoadableImage"])
    ],
    swiftLanguageVersions: [SwiftVersion.v5]
)
