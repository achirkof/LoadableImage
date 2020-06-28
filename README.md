<h1>
    <img align="left" width="50" src="../assets/LoadableImage-icon.png" alt="LoadableImage Header Logo"/> LoadableImage
</h1>

![Supported platforms](https://img.shields.io/badge/platform-iOS-lightgrey)
![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/achirkof/LoadableImage?include_prereleases)
[![Build Status](https://travis-ci.com/achirkof/LoadableImage.svg?branch=master)](https://travis-ci.com/achirkof/LoadableImage)
[![codecov](https://codecov.io/gh/achirkof/LoadableImage/branch/master/graph/badge.svg)](https://codecov.io/gh/achirkof/LoadableImage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

[![Imgur](https://imgur.com/iN7zYlQ.gif)](https://imgur.com/iN7zYlQ.gif)

### How to use

Usage of __ImageLoadable__ as simple as SwiftUI __Image__.

```swift
import SwiftUI
import LoadableImage

struct ContentView: View {
    var body: some View {
        HStack {
            ImageLoadable(
                loadable: URL(string: "https://robohash.org/loadablerobot"),
                contentMode: .fit
            )
            .frame(width: 140, height: 140)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)

            ImageLoadable(
                loadable: "image_from_assets"
            )
            .frame(width: 140, height: 140)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            }
        }
    }
}

```

You can also use loadable image as a property in your model and it Decodes from JSON. For example

```swift
struct Robot: Decodable {
    var name: String
    var localImage: AnyImageLoadable<String>? // for image from assets
    var remoteImage: AnyImageLoadable<URL>? // for image from network
}
```

It's also possible and very convenient while unit testing or using [Xcode preview](https://developer.apple.com/videos/play/wwdc2019/233/) to create mock objects with image. For example:

```swift
let robot: Robot = Robot(
    name: "Bender",
    image: URL(string: "https://robohash.org/loadablerobot")?.eraseToAnyLoadable()
)
```

Consider [__Example__](https://github.com/achirkof/LoadableImage/tree/example) project for further details.

### Installation

Use Swift Package Manager to install. The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

Once you have your Swift package set up, adding LoadableImage as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/achirkof/LoadableImage.git", from: "1.0.0-beta.1")
]
```

Or just add package to your project:
1. File → Swift Packages → Add Package Dependency...
2. Paste the repository URL: https://github.com/achirkof/LoadableImage.git

### Future plans
- [x] Make `ImageLoadable` possible to work also with images from `Assets` catalog 
- [x] Use URL caching to reduce network traffic and increase image loading speed
- [x] Make `ImageLoadable` Decodable to be able use it as type in the model
- [ ] Rewrite from `dataTask` to `downloadTask` to decrease memory usage for big images
