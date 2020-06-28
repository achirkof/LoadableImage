//
//  ActivityIndicator.swift
//
//  Created by CHIRKOV Andrey on 12.01.2020.
//

import SwiftUI

@available(iOS 13.0.0, macOS 10.15, *)
struct ProgressIndicator: View {
    public var body: some View {
        if #available(iOS 14.0, macOS 10.16, *) {
            return AnyView(ProgressView())
        } else {
            return AnyView(ActivityIndicator(isAnimating: true))
        }
    }
}

#if os(iOS)
public struct ActivityIndicator: UIViewRepresentable {
    public typealias UIView = UIActivityIndicatorView

    private var isAnimating: Bool

    fileprivate var configuration = { (_: UIView) in }

    public init(
        isAnimating: Bool
    ) {
        self.isAnimating = isAnimating
    }

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}
#elseif os(OSX)
@available(iOS 13.0, macOS 10.15, *)
public struct ActivityIndicator: NSViewRepresentable {
    public typealias NSViewType = NSProgressIndicator

    private var isAnimating: Bool

    fileprivate var configuration = { (_: NSViewType) in }

    public init(
        isAnimating: Bool
    ) {
        self.isAnimating = isAnimating
    }

    public func makeNSView(context: NSViewRepresentableContext<Self>) -> NSViewType { NSProgressIndicator() }

    public func updateNSView(_ uiView: NSViewType, context: NSViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimation(nil) : uiView.stopAnimation(nil)
        configuration(uiView)
    }
}
#endif
