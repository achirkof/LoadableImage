//
//  ContentView.swift
//  LoadableImageExample
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//  Copyright © 2020 Andrey CHIRKOV. All rights reserved.
//

import LoadableImage
import SwiftUI

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
