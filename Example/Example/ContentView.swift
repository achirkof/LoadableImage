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
        VStack {
            HStack {
                VStack {
                    ImageLoading(
                        image: URL(string: imageURL)!,
                        contentMode: .fit
                    )
                    .frame(width: 140, height: 140)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)

                    Text("from URL")
                        .frame(width: 140)
                }

                VStack {
                    ImageLoading(
                        image: URL(string: brokenImageURL)!,
                        contentMode: .fit,
                        placeholder: UIImage(named: "noImage")
                    )
                    .frame(width: 140, height: 140)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)

                    Text("load Error")
                        .frame(width: 140)
                }
            }

            VStack {
                ImageLoading(
                    image: UIImage(named: "robot4H1")!,
                    contentMode: .fit
                )
                .frame(width: 140, height: 140)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)

                Text("from Assets")
                    .frame(width: 140)
            }
        }
    }
}
