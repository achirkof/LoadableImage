// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "LoadableImage",
    platforms: [
        SupportedPlatform.iOS(SupportedPlatform.IOSVersion.v13)
    ],
    products: [
        Product.library(name: "LoadableImage", targets: ["LoadableImage"])
    ],
    dependencies: [],
    targets: [
        Target.target(name: "LoadableImage", dependencies: [], exclude: ["Example"]),
        Target.testTarget(name: "LoadableImageTests", dependencies: ["LoadableImage"])
    ],
    swiftLanguageVersions: [SwiftVersion.v5]
)
