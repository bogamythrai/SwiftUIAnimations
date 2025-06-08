//
//  BasicLoader.swift
//  SwiftUIAnimations
//
//  Created by Mythrai Boga on 14/01/25.
//

import SwiftUI

struct BasicLoaderView: View {
    @State private var isAnimating: Bool = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(0.5),
                    lineWidth: 4
                )
                .frame(width: 50, height: 50)

            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 4, lineCap: .round)
                )
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct BasicLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        BasicLoaderView()
    }
}
