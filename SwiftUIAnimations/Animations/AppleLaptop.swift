//
//  AppleLogo.swift
//  SwiftUIAnimations
//
//  Created by Mythrai Boga on 14/01/25.
//

import SwiftUI

struct LaptopView: View {
    // MARK: - Properties
    @State private var isOpen = false
    @State private var lidAngle: Double = 0
    @State private var textOffset: CGFloat = 100 // For text animation

    // Constants
    private let maxOpenAngle: Double = 120
    private let snapThreshold: Double = 60
    private let autoOpenThreshold: Double = 100
    private let dragSensitivity: Double = 0.5

    private var instructions: String {
        switch isOpen {
        case true:
            return "Swipe down the lid to close the laptop"
        case false:
            return "Swipe up the lid to open the laptop"
        }
    }

    // MARK: - Body
    var body: some View {
        VStack {
            instructionsView
            Spacer()
            ZStack {
                laptopBase
                laptopLid
            }
            .rotation3DEffect(.degrees(30),
                              axis: (x: 1.0, y: 0.0, z: 0.0))
            .padding(50)
        }
    }

    // MARK: - Instructions
    private var instructionsView: some View {
        ZStack(alignment: .center) {
            // This is an invisible text placeholder to reserve space
            Text(instructions)
                .lineLimit(2, reservesSpace: true)
                .font(.headline)
        }
        .padding()
    }

    // MARK: - Components
    private var laptopBase: some View {
        Rectangle()
            .frame(width: 250, height: 150)
            .foregroundColor(.gray)
            .cornerRadius(10)
            .shadow(radius: 10, x: 0, y: 10)
            .overlay {
                Image(systemName: "keyboard")
                    .font(.system(size: 150))
                    .foregroundColor(.white)
            }
    }

    private var laptopLid: some View {
        Rectangle()
            .frame(width: 250, height: 140)
            .foregroundColor(.init(red: 0.2, green: 0.2, blue: 0.2))
            .cornerRadius(10)
            .overlay {
                appleLogo
            }
            .rotation3DEffect(
                .degrees(isOpen ? maxOpenAngle : lidAngle),
                axis: (x: 1.0, y: 0.0, z: 0.0),
                anchor: .top
            )
            .animation(.easeInOut(duration: 1), value: isOpen)
            .gesture(dragGesture)
            .onTapGesture {
                isOpen.toggle()
            }
    }

    private var appleLogo: some View {
        Image(systemName: "applelogo")
            .font(.system(size: 50))
            .foregroundColor(.white)
            .opacity(isOpen ? 0 : 1)
    }

    // MARK: - Gestures
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                // Upward drag opens the lid
                let dragDistance = -value.translation.height
                lidAngle = min(maxOpenAngle, max(0, dragDistance * dragSensitivity))

                // Auto-open when nearly fully opened
                if lidAngle > autoOpenThreshold {
                    isOpen = true
                }
            }
            .onEnded { _ in
                // Snap to open or closed position based on threshold
                isOpen = lidAngle > snapThreshold
                lidAngle = 0 // Reset for animation
            }
    }
}

// MARK: - Preview
struct LaptopContentView: View {
    var body: some View {
        LaptopView()
            .frame(width: 250, height: 200)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaptopContentView()
    }
}
