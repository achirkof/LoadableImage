import LoadableImage
import PlaygroundSupport
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    ImageLoadable(
                        source: "https://robohash.org/loadablerobot",
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
                    ImageLoadable(
                        source: "robot4H1",
                        contentMode: .fit
                    )
                    .frame(width: 140, height: 140)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)

                    Text("from Assets")
                        .frame(width: 140)
                }

                VStack {
                    ImageLoadable(
                        source: "https://broken.url",
                        contentMode: .fit,
                        placeholder: UIImage(named: "imageLoadError")
                    )
                    .frame(width: 140, height: 140)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)

                    Text("load Error")
                        .frame(width: 140)
                }
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
