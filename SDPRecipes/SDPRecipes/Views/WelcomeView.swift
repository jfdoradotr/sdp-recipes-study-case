//
//  WelcomeView.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import SwiftUI

struct WelcomeView: View {
  @Binding var isFirstTime: Bool

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
        isFirstTime = false
      }
      .buttonStyle(StrokedButtonStyle())

    }
  }
}

struct StrokedButtonStyle: ButtonStyle {
  @State private var isAnimating = false

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
            .blur(radius: isAnimating ? 4 : 12)
            .opacity(0.7)
            .onAppear {
              withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isAnimating = true
              }
            }

          Capsule()
            .fill(.white)
            .stroke(Color.black, lineWidth: 3)
        }
      }
  }
}

#Preview {
  WelcomeView(isFirstTime: .constant(true))
}
