// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "LoadableImage",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LoadableImage",
            targets: ["LoadableImage"]
        )
    ],
    targets: [
        .target(
            name: "LoadableImage",
            exclude: [
                "../Example",
                "Dangerfile.swift",
                "codecov.yml"
            ]
        ),
        .testTarget(
            name: "LoadableImageTests",
            dependencies: ["LoadableImage"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
