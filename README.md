![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/achirkof/LoadableImage?include_prereleases)
[![Build Status](https://travis-ci.com/achirkof/LoadableImage.svg?branch=master)](https://travis-ci.com/achirkof/LoadableImage)
[![codecov](https://codecov.io/gh/achirkof/LoadableImage/branch/master/graph/badge.svg)](https://codecov.io/gh/achirkof/LoadableImage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# LoadableImage

This is a lightweight package provided easy and powerful way to show remote image in SwiftUI interface.

[![Imgur](https://imgur.com/iN7zYlQ.gif)](https://imgur.com/iN7zYlQ.gif)

### How to use

Usage of ImageLoadable as simple as SwiftUI `struct Image`.

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

ImageLoadable has one *required* parameter:

`imageURL` - provide an image remote URL;

and two *optional* parameters:

`contentMode` - provide image content mode. Default walue is `ContentMode.fit`.

`placeholder` - provide image placeholder you want to display if download failed. Default image placeholder is SFSymbol named 'wifi.exclamationmark'  [![Imgur](https://imgur.com/hbK2bJb.png)](https://imgur.com/hbK2bJb.png)

### Installation

Use Swift Package Manager to install. The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding LoadableImage as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/achirkof/LoadableImage.git", from: "0.1.0")
]
```
