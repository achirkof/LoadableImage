![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/achirkof/LoadableImage?include_prereleases)
[![Build Status](https://travis-ci.com/achirkof/LoadableImage.svg?branch=master)](https://travis-ci.com/achirkof/LoadableImage)
[![codecov](https://codecov.io/gh/achirkof/LoadableImage/branch/master/graph/badge.svg)](https://codecov.io/gh/achirkof/LoadableImage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# LoadableImage

This is a lightweight package provided easy and powerful way to show remote image in SwiftUI interface.

[![Imgur](https://imgur.com/iN7zYlQ.gif)](https://imgur.com/iN7zYlQ.gif)

### How to use

Usage of __ImageLoadable__ as simple as SwiftUI __Image__.

```swift
import SwiftUI
import LoadableImage

struct ContentView: View {
    private let imageURL = "https://robohash.org/loadablerobot"
    private let brokenImageURL = "https://broken.url"

    var body: some View {
        HStack {
            VStack {
                ImageLoadable(imageURL: imageURL, contentMode: .fit)
                    .frame(width: 140, height: 140)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)

                Text("Image loaded successfully")
                    .frame(width: 140)
            }

            VStack {
                ImageLoadable(imageURL: brokenImageURL, contentMode: .fit, placeholder: UIImage(named: "noImage"))
                    .frame(width: 140, height: 140)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)

                Text("Image load error. Show placeholder")
                    .frame(width: 140)
            }
        }
    }
}

```

ImageLoadable has one *__required__* parameter:

`imageURL: String` - provide a remote image URL;

and two *__optional__* parameters:

`contentMode: ContentMode` - provide image content mode. Default walue is `ContentMode.fit`.

`placeholder: UIImage` - provide image placeholder you want to display if download failed. Default image placeholder is SFSymbol named *wifi.exclamationmark*  [![Imgur](https://imgur.com/hbK2bJb.png)](https://imgur.com/hbK2bJb.png)

Consider [__Example__](https://github.com/achirkof/LoadableImage/tree/master/Example) project for further details.

### Installation

Use Swift Package Manager to install. The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

Once you have your Swift package set up, adding LoadableImage as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/achirkof/LoadableImage.git", from: "0.3.0")
]
```

Or just add package to your project:
1. File → Swift Packages → Add Package Dependency...
2. Paste the repository URL: https://github.com/achirkof/LoadableImage.git

### Future plans
- [x] Make `ImageLoadable` Codable to be able use it as type in the model
- [x] Make `ImageLoadable` possible to work also with images from `Assets` catalog 
- [ ] Rewrite from `dataTask` to `downloadTask` to decrease memory usage for big images
- [ ] Make it possible to *optionally* set caching strategy 
