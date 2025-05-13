//
//  WelcomeView.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import SwiftUI

struct WelcomeView: View {
  var body: some View {
    VStack(spacing: 32) {
      VStack(spacing: 8) {
        Text("Hi Chef! 🧑‍🍳")
          .font(.largeTitle)
          .fontWeight(.bold)
        Text("Looking for new recipes?\nYou're in the right place.")
          .foregroundStyle(.secondary)
      }

      Button("Press to continue") {
        // TODO: Action
      }
      .buttonStyle(StrokedButtonStyle())

    }
  }
}

struct StrokedButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.headline)
      .fontWeight(.bold)
      .padding(.vertical, 8)
      .padding(.horizontal, 24)
      .background {
        ZStack {
          RoundedRectangle(cornerRadius: 25)
            .fill(AngularGradient(colors: [.blue, .purple, .pink, .blue], center: .center))
            .blur(radius: 8)
            .opacity(0.7)
            .rotationEffect(.degrees(configuration.isPressed ? 360 : 0))
            .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: configuration.isPressed)

          Capsule()
            .fill(.white)
            .stroke(Color.black, lineWidth: 3)
        }
      }
  }
}

#Preview {
  WelcomeView()
}
