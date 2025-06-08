//
//  GearLoading.swift
//  SwiftUIAnimations
//
//  Created by Mythrai Boga on 14/01/25.
//

import SwiftUI

struct GearLoader: View {
    enum Size {
        case small, medium, large

        var dimensions: (width: CGFloat, height: CGFloat, spokeWidth: CGFloat, spokeHeight: CGFloat, spokeOffset: CGFloat) {
            switch self {
                case .small:
                    return (30, 30, 1.5, 6, -9)
                case .medium:
                    return (40, 40, 2, 8, -12)
                case .large:
                    return (60, 60, 3, 12, -18)
            }
        }
    }

    enum Theme {
        case black, white

        var color: Color {
            switch self {
                case .black:
                    return Color.gray
                case .white:
                    return Color.white
            }
        }
    }

    @State private var rotation = 0.0
    private let size: Size
    private let theme: Theme

    init(size: Size = .medium, theme: Theme = .white) {
        self.size = size
        self.theme = theme
    }

    var body: some View {
        GearLoading(size: size, theme: theme)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false)
                ) {
                    rotation = 360
                }
            }
    }

    fileprivate struct GearLoading: View {
        private let totalSpokes = 12
        private let size: Size
        private let theme: Theme

        init(size: Size, theme: Theme = .white) {
            self.size = size
            self.theme = theme
        }

        var body: some View {
            ZStack {
                ForEach(0..<totalSpokes, id: \.self) { index in
                    SpokeView(index: index,
                              totalSpokes: totalSpokes,
                              size: size,
                              theme: theme)
                }
            }
            .frame(width: size.dimensions.width, height: size.dimensions.height)
        }
    }

    fileprivate struct SpokeView: View {
        let index: Int
        let totalSpokes: Int
        let size: Size
        let theme: Theme

        var body: some View {
            let opacity = 1.0 - (Double(index) / Double(totalSpokes) * 0.8)
            let dimensions = size.dimensions

            Capsule()
                .fill(theme.color)
                .frame(width: dimensions.spokeWidth, height: dimensions.spokeHeight)
                .opacity(opacity)
                .offset(y: dimensions.spokeOffset)
                .rotationEffect(Angle(degrees: Double(index) * (360.0/Double(totalSpokes))))
        }
    }
}

struct GearLoadingContentView: View {
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 30) {
                GearLoader(size: .small, theme: .black)
                GearLoader(size: .medium, theme: .black)
                GearLoader(size: .large, theme: .black)
            }
        }
    }
}

#Preview {
    GearLoadingContentView()
}
