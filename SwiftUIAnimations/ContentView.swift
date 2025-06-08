//
//  ContentView.swift
//  SwiftUIAnimations
//
//  Created by Mythrai Boga on 14/01/25.
//

import SwiftUI

// Enum for all animation entry points
enum AnimationEntry: String, Identifiable, CaseIterable {
    case threeDots = "Three Dots"
    case gearLoader = "Gear Loader"
    case basicLoader = "Basic Loader"
    case laptop = "Laptop Animation"

    var id: String { self.rawValue }

    @ViewBuilder
    func destinationView() -> some View {
        switch self {
            case .threeDots:
                ThreeDots()
            case .gearLoader:
                GearLoadingContentView()
            case .basicLoader:
                BasicLoaderView()
            case .laptop:
                LaptopContentView()
        }
    }

    var description: String {
        switch self {
            case .threeDots:
                return "Animation with three bouncing dots"
            case .gearLoader:
                return "iOS-style loading spinner"
            case .basicLoader:
                return "Simple loading animation"
            case .laptop:
                return "Interactive 3D laptop animation"
        }
    }

    var iconName: String {
        switch self {
            case .threeDots:
                return "ellipsis"
            case .gearLoader:
                return "gear"
            case .basicLoader:
                return "circle.dashed"
            case .laptop:
                return "laptopcomputer"
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(AnimationEntry.allCases) { entry in
                    NavigationLink(destination:
                                    entry.destinationView()
                        .navigationTitle(entry.rawValue)
                    ) {
                        HStack {
                            Image(systemName: entry.iconName)
                                .foregroundColor(.blue)
                                .font(.system(size: 24))
                                .frame(width: 32, height: 32)

                            VStack(alignment: .leading) {
                                Text(entry.rawValue)
                                    .font(.headline)
                                Text(entry.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("SwiftUI Animations")
        }
    }
}

#Preview {
    ContentView()
}
