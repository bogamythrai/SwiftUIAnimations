//
//  ThreeDots.swift
//  SwiftUIAnimations
//
//  Created by Mythrai Boga on 14/01/25.
//

import SwiftUI

struct ThreeDots: View {
    @State private var bounce = false
    private let numberOfDots = 3
    var body: some View {
        HStack(spacing: 10, content: {
            ForEach(0..<numberOfDots, id: \.self) { index in
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.blue)
                    .offset(y: bounce ? -10 : 10)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: bounce
                    )
            }
        })
        .frame(width: CGFloat(25 * numberOfDots), height: 50)
        .onAppear(perform: {
            bounce.toggle()
        })
    }
}

#Preview {
    ThreeDots()
}
